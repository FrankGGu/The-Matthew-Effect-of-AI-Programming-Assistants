#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int target) {
        long long sum = accumulate(nums.begin(), nums.end(), 0LL);
        if (sum < target) return -1;

        sort(nums.begin(), nums.end());

        int ans = 0;
        int i = 0;
        while (target > 0) {
            if (nums[i] <= target) {
                target -= nums[i];
                nums.erase(nums.begin() + i);
                i = 0;
            } else {
                if (nums[i] > target && nums[i] <= 2 * target) {

                    long long current_sum = 0;
                    for(int k = 0; k < nums.size(); ++k){
                        current_sum += nums[k];
                    }

                    if(current_sum >= target){

                        while(nums[i] > target){
                            nums.insert(nums.begin() + i + 1, nums[i] / 2);
                            nums[i] /= 2;
                            ans++;
                        }
                        target -= nums[i];
                        nums.erase(nums.begin() + i);
                        i = 0;
                    } else {
                        return -1;
                    }

                } else {
                    if(i < nums.size() - 1){
                        i++;
                    } else {

                        long long current_sum = 0;
                        for(int k = 0; k < nums.size(); ++k){
                            current_sum += nums[k];
                        }

                        if(current_sum >= target){
                            while(nums[i] > target){
                                nums.insert(nums.begin() + i + 1, nums[i] / 2);
                                nums[i] /= 2;
                                ans++;
                            }
                            target -= nums[i];
                            nums.erase(nums.begin() + i);
                            i = 0;
                        } else {
                            return -1;
                        }

                    }
                }
            }
            if(nums.empty() && target > 0) return -1;
        }

        return ans;
    }
};