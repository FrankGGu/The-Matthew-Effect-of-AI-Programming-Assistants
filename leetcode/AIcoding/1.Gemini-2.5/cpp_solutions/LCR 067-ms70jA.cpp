#include <vector>
#include <algorithm>

class Solution {
public:
    struct TrieNode {
        TrieNode* children[2];
        TrieNode() {
            children[0] = nullptr;
            children[1] = nullptr;
        }
    };

    void insert(TrieNode* root, int num) {
        TrieNode* curr = root;
        // Iterate from the most significant bit (30th bit for 31-bit integers) down to 0
        // This covers numbers up to 2^31 - 1.
        // Given nums[i] <= 2 * 10^9, 30 is the correct highest bit index.
        for (int i = 30; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (curr->children[bit] == nullptr) {
                curr->children[bit] = new TrieNode();
            }
            curr = curr->children[bit];
        }
    }

    int findMaxXor(TrieNode* root, int num) {
        TrieNode* curr = root;
        int maxXor = 0;
        for (int i = 30; i >= 0; --i) {
            int bit = (num >> i) & 1;
            // Try to find the opposite bit in the Trie to maximize XOR
            if (curr->children[1 - bit] != nullptr) {
                maxXor |= (1 << i); // Set the i-th bit of maxXor to 1
                curr = curr->children[1 - bit];
            } else {
                // If the opposite bit path doesn't exist, we must take the same bit
                // This means the i-th bit of maxXor will be 0 (bit ^ bit = 0)
                curr = curr->children[bit];
            }
        }
        return maxXor;
    }

    int findMaximumXOR(std::vector<int>& nums) {
        TrieNode* root = new TrieNode();

        // Insert all numbers into the Trie
        for (int num : nums) {
            insert(root, num);
        }

        int overallMaxXor = 0;
        // For each number, find the maximum XOR it can form with any other number in the Trie
        for (int num : nums) {
            overallMaxXor = std::max(overallMaxXor, findMaxXor(root, num));
        }

        // Clean up Trie memory (optional for LeetCode, but good practice)
        std::vector<TrieNode*> q;
        q.push_back(root);
        int head = 0;
        while(head < q.size()){
            TrieNode* node = q[head++];
            if(node->children[0]) q.push_back(node->children[0]);
            if(node->children[1]) q.push_back(node->children[1]);
            delete node;
        }

        return overallMaxXor;
    }
};