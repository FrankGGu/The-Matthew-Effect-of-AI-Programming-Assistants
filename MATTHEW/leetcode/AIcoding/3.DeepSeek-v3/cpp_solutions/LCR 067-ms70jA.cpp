class Solution {
private:
    struct TrieNode {
        TrieNode* children[2];
        TrieNode() {
            children[0] = nullptr;
            children[1] = nullptr;
        }
    };

    TrieNode* root = new TrieNode();

    void insert(int num) {
        TrieNode* node = root;
        for (int i = 31; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (!node->children[bit]) {
                node->children[bit] = new TrieNode();
            }
            node = node->children[bit];
        }
    }

    int findMaxXor(int num) {
        TrieNode* node = root;
        int maxXor = 0;
        for (int i = 31; i >= 0; --i) {
            int bit = (num >> i) & 1;
            int flipBit = 1 - bit;
            if (node->children[flipBit]) {
                maxXor |= (1 << i);
                node = node->children[flipBit];
            } else {
                node = node->children[bit];
            }
        }
        return maxXor;
    }

public:
    int findMaximumXOR(vector<int>& nums) {
        int maxResult = 0;
        for (int num : nums) {
            insert(num);
        }
        for (int num : nums) {
            maxResult = max(maxResult, findMaxXor(num));
        }
        return maxResult;
    }
};