#include <vector>
#include <numeric>

class Solution {
public:
    int sumOfUnique(std::vector<int>& nums) {
        int freq[101] = {0};
        for (int num : nums) {
            freq[num]++;
        }

        int sum = 0;
        for (int i = 1; i <= 100; ++i) {
            if (freq[i] == 1) {
                sum += i;
            }
        }
        return sum;
    }
};