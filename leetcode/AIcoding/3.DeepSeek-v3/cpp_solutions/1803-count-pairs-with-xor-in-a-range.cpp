class Solution {
public:
    int countPairs(vector<int>& nums, int low, int high) {
        return countXOR(nums, high) - countXOR(nums, low - 1);
    }

private:
    int countXOR(vector<int>& nums, int x) {
        int count = 0;
        TrieNode* root = new TrieNode();
        for (int num : nums) {
            count += query(root, num, x);
            insert(root, num);
        }
        return count;
    }

    struct TrieNode {
        TrieNode* children[2];
        int count;
        TrieNode() {
            children[0] = children[1] = nullptr;
            count = 0;
        }
    };

    void insert(TrieNode* root, int num) {
        TrieNode* node = root;
        for (int i = 14; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (node->children[bit] == nullptr) {
                node->children[bit] = new TrieNode();
            }
            node = node->children[bit];
            node->count++;
        }
    }

    int query(TrieNode* root, int num, int x) {
        TrieNode* node = root;
        int res = 0;
        for (int i = 14; i >= 0; --i) {
            if (node == nullptr) break;
            int numBit = (num >> i) & 1;
            int xBit = (x >> i) & 1;
            if (xBit == 1) {
                if (node->children[numBit] != nullptr) {
                    res += node->children[numBit]->count;
                }
                node = node->children[1 - numBit];
            } else {
                node = node->children[numBit];
            }
        }
        return res;
    }
};