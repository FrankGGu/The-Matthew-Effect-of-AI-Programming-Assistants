#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int numberOfSubsequencesWithEqualGCD(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> freq(100001, 0);
        for (int num : nums) {
            freq[num]++;
        }

        int result = 0;
        for (int g = 1; g <= 100000; ++g) {
            if (g % k != 0) continue;
            int count = 0;
            for (int i = g; i <= 100000; i += g) {
                count += freq[i];
            }
            if (count >= 1) {
                result += (1 << count) - 1;
            }
        }
        return result;
    }
};