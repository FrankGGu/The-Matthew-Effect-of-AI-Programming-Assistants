#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeSubarrays(vector<int>& nums) {
        int n = nums.size();
        int ans = 0;
        for (int i = -1; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                vector<int> temp;
                for (int k = 0; k < n; ++k) {
                    if (k != i && k != j) {
                        temp.push_back(nums[k]);
                    } else if (i == -1 && k != j) {
                         temp.push_back(nums[k]);
                    } else if (j == n && k != i) {
                        temp.push_back(nums[k]);
                    }
                }

                if (i == -1 && j == n) temp = nums;
                else if(i == -1) {
                    vector<int> temp2;
                    for(int k = 0; k < n; ++k) {
                        if(k != j) temp2.push_back(nums[k]);
                    }
                    temp = temp2;
                } else if(j == n) {
                    vector<int> temp2;
                    for(int k = 0; k < n; ++k) {
                        if(k != i) temp2.push_back(nums[k]);
                    }
                    temp = temp2;
                }

                int curr = 0;
                int subarrayCount = 0;
                for (int k = 0; k < temp.size(); ++k) {
                    curr |= temp[k];
                    if (curr == 0) {
                        subarrayCount++;
                        curr = 0;
                    }
                }

                ans = max(ans, subarrayCount);
            }
        }
        return ans;
    }
};