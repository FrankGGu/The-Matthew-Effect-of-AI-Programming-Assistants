class Solution {
public:
    vector<int> maxXorQueries(vector<int>& nums, vector<vector<int>>& queries) {
        sort(nums.begin(), nums.end());
        vector<int> res(queries.size());
        vector<pair<pair<int, int>, int>> qs;
        for (int i = 0; i < queries.size(); ++i) {
            qs.push_back({{queries[i][1], queries[i][0]}, i});
        }
        sort(qs.begin(), qs.end());

        int idx = 0;
        TrieNode* root = new TrieNode();
        for (auto& q : qs) {
            int x = q.first.second;
            int m = q.first.first;
            int i = q.second;
            while (idx < nums.size() && nums[idx] <= m) {
                insert(root, nums[idx]);
                ++idx;
            }
            if (idx == 0) {
                res[i] = -1;
            } else {
                res[i] = query(root, x);
            }
        }
        return res;
    }

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
            if (node->children[bit] == nullptr) {
                node->children[bit] = new TrieNode();
            }
            node = node->children[bit];
        }
    }

    int query(TrieNode* root, int x) {
        TrieNode* node = root;
        int res = 0;
        for (int i = 31; i >= 0; --i) {
            int bit = (x >> i) & 1;
            if (node->children[1 - bit] != nullptr) {
                res |= (1 << i);
                node = node->children[1 - bit];
            } else {
                node = node->children[bit];
            }
        }
        return res;
    }
};