#include <vector>

using namespace std;

class Solution {
public:
    long long findPowerSum(vector<int>& nums, int k, int power) {
        int n = nums.size();
        long long ans = 0;
        for (int i = 0; i <= n - k; ++i) {
            long long sum = 0;
            for (int j = i; j < i + k; ++j) {
                sum += nums[j];
            }
            ans += pow(sum, power);
        }
        return ans;
    }
};