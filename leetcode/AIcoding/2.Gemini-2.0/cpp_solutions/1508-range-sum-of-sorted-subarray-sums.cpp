#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int rangeSum(vector<int>& nums, int n, int left, int right) {
        vector<int> subarraySums;
        for (int i = 0; i < n; ++i) {
            int currentSum = 0;
            for (int j = i; j < n; ++j) {
                currentSum += nums[j];
                subarraySums.push_back(currentSum);
            }
        }

        sort(subarraySums.begin(), subarraySums.end());

        long long sum = 0;
        long long mod = 1e9 + 7;
        for (int i = left - 1; i < right; ++i) {
            sum = (sum + subarraySums[i]) % mod;
        }

        return (int)sum;
    }
};