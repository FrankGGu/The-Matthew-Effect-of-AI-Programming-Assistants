#include <vector>
#include <unordered_set>

class Solution {
public:
    int arithmeticTriplets(std::vector<int>& nums, int diff) {
        std::unordered_set<int> numSet;
        for (int num : nums) {
            numSet.insert(num);
        }

        int count = 0;
        for (int num : nums) {
            if (numSet.count(num + diff) && numSet.count(num + 2 * diff)) {
                count++;
            }
        }
        return count;
    }
};