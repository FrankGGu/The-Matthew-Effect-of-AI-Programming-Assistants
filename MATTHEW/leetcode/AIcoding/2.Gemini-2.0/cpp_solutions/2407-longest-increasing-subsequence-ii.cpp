#include <vector>

using namespace std;

class Solution {
public:
    int lengthOfLIS(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp;
        for (int i = 0; i < n; ++i) {
            int num = nums[i];
            auto it = upper_bound(dp.begin(), dp.end(), num);
            if (it == dp.begin()) {
                dp.insert(dp.begin(), num);
            } else {
                auto prev_it = prev(it);
                if (*prev_it >= num - k) {
                    if (it != dp.end()) {
                        *it = num;
                    } else {
                        dp.push_back(num);
                    }
                } else {
                    if (it != dp.end()) {

                        if(*it > num)
                            *it = num;
                    }
                    else{
                        dp.push_back(num);
                    }
                }
            }
            int j = 0;
            while(j < dp.size() - 1){
                if(dp[j+1] <= dp[j]){
                    dp.erase(dp.begin() + j);
                } else {
                    j++;
                }
            }
        }
        return dp.size();
    }
};