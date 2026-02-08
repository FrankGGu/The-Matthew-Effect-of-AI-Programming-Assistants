#include <vector>
#include <numeric>

class Solution {
public:
    bool divideArray(std::vector<int>& nums) {
        int freq[1001] = {0};

        for (int num : nums) {
            freq[num]++;
        }

        for (int i = 0; i <= 1000; ++i) {
            if (freq[i] % 2 != 0) {
                return false;
            }
        }

        return true;
    }
};