#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxStrength(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long ans = 1;
        int neg_count = 0;
        for (int num : nums) {
            if (num < 0) {
                neg_count++;
            }
        }

        if (nums.size() == 1) {
            return nums[0];
        }

        if (neg_count == nums.size() && neg_count % 2 != 0) {

            int max_neg = nums[0];
            for (int i = 1; i < nums.size(); ++i){
                max_neg = max(max_neg, nums[i]);
            }
            return max_neg;
        }

        bool has_positive = false;
        for (int num : nums) {
            if (num > 0) {
                has_positive = true;
                break;
            }
        }

        if (!has_positive && neg_count == nums.size() && neg_count % 2 != 0 && nums.size() > 1){
            int max_neg = nums[0];
            for (int i = 1; i < nums.size(); ++i){
                max_neg = max(max_neg, nums[i]);
            }
            return max_neg;
        }

        if (!has_positive && neg_count == nums.size() && neg_count % 2 != 0 && nums.size() == 1) return nums[0];

        int start = 0;
        if (nums[0] == 0 && nums.size() > 1){
            start = 1;
            while(start < nums.size() && nums[start] <= 0){
                start++;
            }
            if(start == nums.size() && neg_count % 2 != 0){

                return 0;
            }
            if(start == nums.size() && neg_count % 2 == 0){
                 for (int i = 0; i < nums.size(); ++i) {
                     if(nums[i] != 0){
                         if(nums[i] < 0 && neg_count % 2 != 0){
                             continue;
                         }
                         ans *= nums[i];
                     }
                 }
                return ans;
            }
        }

        for (int i = 0; i < nums.size(); ++i) {
            if(nums[i] != 0){
                if(nums[i] < 0 && neg_count % 2 != 0){
                    neg_count--;
                    continue;
                }
                ans *= nums[i];
            }
        }

        return ans;
    }
};