#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int maxRotateFunction(vector<int>& nums) {
        int n = nums.size();
        int sum = 0;
        int f = 0;

        for (int i = 0; i < n; i++) {
            sum += nums[i];
            f += i * nums[i];
        }

        int maxF = f;

        for (int i = n - 1; i > 0; i--) {
            f = f + sum - n * nums[i];
            if (f > maxF) {
                maxF = f;
            }
        }

        return maxF;
    }
};