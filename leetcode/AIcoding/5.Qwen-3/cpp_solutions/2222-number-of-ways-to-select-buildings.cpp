#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long numberOfWays(vector<int>& nums) {
        int n = nums.size();
        vector<long long> count0(n, 0);
        vector<long long> count1(n, 0);

        for (int i = 1; i < n; ++i) {
            if (nums[i - 1] == 0) {
                count0[i] = count0[i - 1] + 1;
                count1[i] = count1[i - 1];
            } else {
                count0[i] = count0[i - 1];
                count1[i] = count1[i - 1] + 1;
            }
        }

        long long result = 0;
        for (int i = 1; i < n - 1; ++i) {
            if (nums[i] == 0) {
                result += count1[i] * (count0[n - 1] - count0[i]);
            } else {
                result += count0[i] * (count1[n - 1] - count1[i]);
            }
        }

        return result;
    }
};