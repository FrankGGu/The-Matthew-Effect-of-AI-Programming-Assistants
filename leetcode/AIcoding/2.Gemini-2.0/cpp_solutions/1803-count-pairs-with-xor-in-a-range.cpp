#include <vector>

using namespace std;

class Solution {
public:
    int countPairs(vector<int>& nums, int low, int high) {
        return countPairsLessThan(nums, high + 1) - countPairsLessThan(nums, low);
    }

private:
    struct TrieNode {
        TrieNode* children[2] = {nullptr, nullptr};
        int count = 0;
    };

    void insert(TrieNode* root, int num) {
        TrieNode* curr = root;
        for (int i = 15; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (!curr->children[bit]) {
                curr->children[bit] = new TrieNode();
            }
            curr = curr->children[bit];
            curr->count++;
        }
    }

    int countLessThan(TrieNode* root, int num, int limit) {
        TrieNode* curr = root;
        int count = 0;
        for (int i = 15; i >= 0; --i) {
            if (!curr) return 0;
            int numBit = (num >> i) & 1;
            int limitBit = (limit >> i) & 1;

            if (limitBit == 1) {
                if (curr->children[numBit]) {
                    count += curr->children[numBit]->count;
                }
                curr = curr->children[1 - numBit];
            } else {
                curr = curr->children[numBit];
            }
        }
        if (curr) count += curr->count;
        return count;
    }

    int countPairsLessThan(vector<int>& nums, int limit) {
        TrieNode* root = new TrieNode();
        int count = 0;
        for (int num : nums) {
            count += countLessThan(root, num, limit);
            insert(root, num);
        }
        return count;
    }
};