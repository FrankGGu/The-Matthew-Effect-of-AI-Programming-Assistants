#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int findMaximumXOR(std::vector<int>& nums) {
        int max_xor = 0;
        int mask = 0;

        for (int i = 30; i >= 0; --i) {
            mask |= (1 << i);

            std::unordered_set<int> prefixes;
            for (int num : nums) {
                prefixes.insert(num & mask);
            }

            int potential_max_xor = max_xor | (1 << i);

            for (int p : prefixes) {
                if (prefixes.count(potential_max_xor ^ p)) {
                    max_xor = potential_max_xor;
                    break; 
                }
            }
        }

        return max_xor;
    }
};