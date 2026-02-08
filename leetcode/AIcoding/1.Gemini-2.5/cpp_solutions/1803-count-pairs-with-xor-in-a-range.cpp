#include <vector>
#include <algorithm> // For std::max, not strictly needed for this solution but good for general competitive programming

class TrieNode {
public:
    TrieNode* children[2];
    int count; // Number of elements whose prefix passes through this node

    TrieNode() : count(0) {
        children[0] = children[1] = nullptr;
    }

    // Destructor to free memory recursively
    ~TrieNode() {
        delete children[0];
        delete children[1];
    }
};

class Solution {
public:
    TrieNode* root;
    // nums[i] up to 2 * 10^4.
    // 2^14 = 16384, 2^15 = 32768.
    // So numbers fit in 15 bits (indices 0 to 14).
    // MAX_BITS is the highest bit index.
    static const int MAX_BITS = 14; 

    // Constructor to initialize root for each test case
    Solution() {
        root = new TrieNode();
    }

    // Destructor to clean up Trie memory
    ~Solution() {
        delete root;
    }

    void insert(int num) {
        TrieNode* curr = root;
        for (int i = MAX_BITS; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (!curr->children[bit]) {
                curr->children[bit] = new TrieNode();
            }
            curr = curr->children[bit];
            curr->count++; 
        }
    }

    int count_less_equal(int x, int limit) {
        if (limit < 0) { // If limit is negative (e.g., low-1 when low is 0), no number can be <= limit
            return 0;
        }

        TrieNode* curr = root;
        int ans = 0;
        for (int i = MAX_BITS; i >= 0 && curr; --i) {
            int x_bit = (x >> i) & 1;
            int limit_bit = (limit >> i) & 1;

            // Option 1: Try to make current XOR bit smaller than limit_bit
            // This is only possible if limit_bit is 1, and we make current XOR bit 0.
            // To make x_bit ^ p_bit = 0, we need p_bit = x_bit.
            if (limit_bit == 1) {
                if (curr->children[x_bit]) { // If path for p_bit = x_bit exists
                    ans += curr->children[x_bit]->count;
                }
            }

            // Option 2: Try to make current XOR bit equal to limit_bit
            // To make x_bit ^ p_bit = limit_bit, we need p_bit = x_bit ^ limit_bit.
            curr = curr->children[x_bit ^ limit_bit];
        }
        // If curr is not null after the loop, it means we found numbers `prev_num`
        // such that `x ^ prev_num` exactly matches `limit` up to bit 0.
        // The count of this final `curr` node is the number of such elements.
        if (curr) {
            ans += curr->count;
        }
        return ans;
    }

    int countPairs(std::vector<int>& nums, int low, int high) {
        long long total_pairs = 0; 

        // The problem asks for pairs (i, j) such that i < j.
        // We iterate through nums. For each num, we query the Trie for previously inserted numbers.
        for (int num : nums) {
            // Count pairs (num, prev_num) such that low <= (num XOR prev_num) <= high
            // This is equivalent to:
            // count(num XOR prev_num <= high) - count(num XOR prev_num < low)
            // which is:
            // count(num XOR prev_num <= high) - count(num XOR prev_num <= low - 1)

            total_pairs += (count_less_equal(num, high) - count_less_equal(num, low - 1));
            insert(num);
        }
        return static_cast<int>(total_pairs);
    }
};