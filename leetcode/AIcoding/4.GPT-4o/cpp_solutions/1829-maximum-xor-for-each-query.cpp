class TrieNode {
public:
    TrieNode* children[2];
    TrieNode() {
        children[0] = children[1] = nullptr;
    }
};

class Trie {
public:
    TrieNode* root;

    Trie() {
        root = new TrieNode();
    }

    void insert(int num) {
        TrieNode* node = root;
        for (int i = 31; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (!node->children[bit]) {
                node->children[bit] = new TrieNode();
            }
            node = node->children[bit];
        }
    }

    int maxXor(int num) {
        TrieNode* node = root;
        int maxXor = 0;
        for (int i = 31; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (node->children[1 - bit]) {
                maxXor |= (1 << i);
                node = node->children[1 - bit];
            } else {
                node = node->children[bit];
            }
        }
        return maxXor;
    }
};

class Solution {
public:
    vector<int> maximizeXor(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        int m = queries.size();
        vector<int> result(m);
        vector<pair<int, pair<int, int>>> indexedQueries(m);

        for (int i = 0; i < m; i++) {
            indexedQueries[i] = {queries[i][1], {queries[i][0], i}};
        }

        sort(nums.begin(), nums.end());
        sort(indexedQueries.begin(), indexedQueries.end());

        Trie trie;
        int j = 0;

        for (const auto& q : indexedQueries) {
            int limit = q.first;
            int x = q.second.first;
            int idx = q.second.second;

            while (j < n && nums[j] <= limit) {
                trie.insert(nums[j]);
                j++;
            }

            result[idx] = (j > 0) ? trie.maxXor(x) : -1;
        }

        return result;
    }
};