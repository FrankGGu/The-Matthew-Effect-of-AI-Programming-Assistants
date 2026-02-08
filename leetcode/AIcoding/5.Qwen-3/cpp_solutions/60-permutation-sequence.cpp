#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string getPermutation(int n, int k) {
        vector<int> nums;
        for (int i = 1; i <= n; ++i) {
            nums.push_back(i);
        }

        vector<int> factorial(n, 1);
        for (int i = 1; i < n; ++i) {
            factorial[i] = factorial[i - 1] * i;
        }

        --k;
        string result;

        for (int i = 0; i < n; ++i) {
            int index = k / factorial[n - 1 - i];
            result.push_back('0' + nums[index]);
            nums.erase(nums.begin() + index);
            k %= factorial[n - 1 - i];
        }

        return result;
    }
};