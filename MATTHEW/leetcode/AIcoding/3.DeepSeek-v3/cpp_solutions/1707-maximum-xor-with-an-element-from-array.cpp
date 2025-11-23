class Solution {
private:
    struct TrieNode {
        TrieNode* children[2];
        TrieNode() {
            children[0] = nullptr;
            children[1] = nullptr;
        }
    };

    void insert(TrieNode* root, int num) {
        TrieNode* node = root;
        for (int i = 31; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (!node->children[bit]) {
                node->children[bit] = new TrieNode();
            }
            node = node->children[bit];
        }
    }

    int findMaxXOR(TrieNode* root, int num) {
        if (!root) return -1;
        TrieNode* node = root;
        int res = 0;
        for (int i = 31; i >= 0; --i) {
            int bit = (num >> i) & 1;
            int toggleBit = 1 - bit;
            if (node->children[toggleBit]) {
                res |= (1 << i);
                node = node->children[toggleBit];
            } else {
                node = node->children[bit];
            }
        }
        return res;
    }

public:
    vector<int> maximizeXor(vector<int>& nums, vector<vector<int>>& queries) {
        vector<int> res(queries.size());
        vector<vector<int>> q;
        for (int i = 0; i < queries.size(); ++i) {
            q.push_back({queries[i][1], queries[i][0], i});
        }
        sort(q.begin(), q.end());
        sort(nums.begin(), nums.end());

        TrieNode* root = new TrieNode();
        int idx = 0;
        for (auto& query : q) {
            int mi = query[0];
            int xi = query[1];
            int qIdx = query[2];
            while (idx < nums.size() && nums[idx] <= mi) {
                insert(root, nums[idx]);
                ++idx;
            }
            int maxXOR = findMaxXOR(root, xi);
            res[qIdx] = maxXOR;
        }
        return res;
    }
};