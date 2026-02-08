#include <vector>
#include <algorithm>

struct TrieNode {
    TrieNode* children[2];
    int count;
    TrieNode() : count(0) {
        children[0] = children[1] = nullptr;
    }
};

class Trie {
private:
    TrieNode* root;
    // Maximum value for nums[i] is 10^9.
    // 2^29 = 536,870,912
    // 2^30 = 1,073,741,824
    // So, numbers up to 10^9 require bits from 0 to 29.
    // We iterate from MSB (bit 29) down to LSB (bit 0).
    const int BITS = 29; 

    void destroy(TrieNode* node) {
        if (!node) return;
        destroy(node->children[0]);
        destroy(node->children[1]);
        delete node;
    }

public:
    Trie() {
        root = new TrieNode();
    }

    ~Trie() {
        destroy(root);
    }

    void insert(int num) {
        TrieNode* curr = root;
        for (int i = BITS; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (!curr->children[bit]) {
                curr->children[bit] = new TrieNode();
            }
            curr = curr->children[bit];
            curr->count++;
        }
    }

    void remove(int num) {
        TrieNode* curr = root;
        for (int i = BITS; i >= 0; --i) {
            int bit = (num >> i) & 1;
            curr = curr->children[bit];
            curr->count--;
        }
    }

    int queryMaxXor(int num) {
        TrieNode* curr = root;
        int maxXor = 0;
        for (int i = BITS; i >= 0; --i) {
            int bit = (num >> i) & 1;
            int desiredBit = 1 - bit;

            if (curr->children[desiredBit] && curr->children[desiredBit]->count > 0) {
                maxXor |= (1 << i);
                curr = curr->children[desiredBit];
            } else {
                curr = curr->children[bit];
            }
        }
        return maxXor;
    }
};

class Solution {
public:
    int maximumStrongPairXor(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());

        Trie trie;
        int maxXor = 0;
        int left = 0;

        for (int right = 0; right < nums.size(); ++right) {
            int x = nums[right];

            // Remove elements from the left of the window that no longer satisfy the condition
            // Condition: y >= x / 2  <==> 2 * y >= x
            while (left < right && 2 * nums[left] < x) {
                trie.remove(nums[left]);
                left++;
            }

            trie.insert(x);

            // Query for the maximum XOR with 'x' from elements currently in the Trie
            // All elements 'y' in the Trie satisfy y >= x/2.
            maxXor = std::max(maxXor, trie.queryMaxXor(x));
        }

        return maxXor;
    }
};