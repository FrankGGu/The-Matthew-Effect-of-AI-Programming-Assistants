#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long zeroFilledSubarrays(vector<int>& nums) {
        long long count = 0;
        long long consecutiveZeros = 0;

        for (int num : nums) {
            if (num == 0) {
                consecutiveZeros++;
                count += consecutiveZeros;
            } else {
                consecutiveZeros = 0;
            }
        }

        return count;
    }
};