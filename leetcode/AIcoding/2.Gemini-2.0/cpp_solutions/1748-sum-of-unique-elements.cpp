#include <vector>
#include <numeric>

class Solution {
public:
    int sumOfUnique(std::vector<int>& nums) {
        std::vector<int> counts(101, 0);
        for (int num : nums) {
            counts[num]++;
        }
        int sum = 0;
        for (int i = 0; i < counts.size(); ++i) {
            if (counts[i] == 1) {
                sum += i;
            }
        }
        return sum;
    }
};