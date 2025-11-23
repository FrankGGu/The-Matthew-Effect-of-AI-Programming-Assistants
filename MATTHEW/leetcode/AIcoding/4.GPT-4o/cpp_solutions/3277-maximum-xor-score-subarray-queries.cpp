class TrieNode {
public:
    TrieNode *children[2];
    TrieNode() {
        children[0] = children[1] = nullptr;
    }
};

class Trie {
public:
    TrieNode *root;
    Trie() {
        root = new TrieNode();
    }

    void insert(int num) {
        TrieNode *node = root;
        for (int i = 31; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (!node->children[bit]) {
                node->children[bit] = new TrieNode();
            }
            node = node->children[bit];
        }
    }

    int maxXOR(int num) {
        TrieNode *node = root;
        int max_xor = 0;
        for (int i = 31; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (node->children[1 - bit]) {
                max_xor |= (1 << i);
                node = node->children[1 - bit];
            } else {
                node = node->children[bit];
            }
        }
        return max_xor;
    }
};

class Solution {
public:
    vector<int> maximumXORSum(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        vector<int> prefixXOR(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixXOR[i + 1] = prefixXOR[i] ^ nums[i];
        }

        Trie trie;
        for (int x : prefixXOR) {
            trie.insert(x);
        }

        vector<int> result;
        for (const auto& query : queries) {
            int l = query[0], r = query[1];
            int xorValue = prefixXOR[r + 1] ^ prefixXOR[l];
            result.push_back(trie.maxXOR(xorValue));
        }

        return result;
    }
};