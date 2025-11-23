#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumSum(vector<int>& nums) {
        int n = nums.size();
        vector<int> leftMin(n);
        vector<int> rightMin(n);

        leftMin[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            leftMin[i] = min(leftMin[i - 1], nums[i]);
        }

        rightMin[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            rightMin[i] = min(rightMin[i + 1], nums[i]);
        }

        long long sum = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] > leftMin[i] || nums[i] > rightMin[i]) continue;
            sum += nums[i];
        }

        long long ans = 0;
        for(int i = 0; i < n; ++i){
            if(nums[i] == leftMin[i] && nums[i] == rightMin[i]){
                ans += nums[i];
            }
        }

        if(ans > 0) return ans;

        long long minVal = *min_element(nums.begin(), nums.end());
        int count = 0;
        for(int num : nums){
            if(num == minVal) count++;
        }
        if(count > 1) return 2 * minVal;

        long long min_sum = -1;
        for(int i = 0; i < n; ++i){
            if(nums[i] == minVal){
                int left_min_val = INT_MAX;
                for(int j = 0; j < i; ++j){
                    left_min_val = min(left_min_val, nums[j]);
                }
                int right_min_val = INT_MAX;
                for(int j = i + 1; j < n; ++j){
                    right_min_val = min(right_min_val, nums[j]);
                }

                long long cur_sum = nums[i] + min(left_min_val == INT_MAX ? (long long)nums[i] : (long long)left_min_val, right_min_val == INT_MAX ? (long long)nums[i] : (long long)right_min_val);
                if(min_sum == -1 || cur_sum < min_sum){
                    min_sum = cur_sum;
                }
            }
        }

        long long res = LLONG_MAX;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                res = min(res, (long long)nums[i] + (long long)nums[j]);
            }
        }
        sort(nums.begin(), nums.end());
        return (long long)nums[0] + (long long)nums[1];
    }
};