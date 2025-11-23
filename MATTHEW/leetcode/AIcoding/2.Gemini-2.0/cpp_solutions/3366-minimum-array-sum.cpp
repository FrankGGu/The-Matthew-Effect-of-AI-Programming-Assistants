#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumArraySum(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long sum = 0;
        long long ans = 0;
        for (int num : nums) {
            sum = max((long long)num, sum + num);
            ans = max(ans, sum);
        }
        return (int)ans;
    }
};