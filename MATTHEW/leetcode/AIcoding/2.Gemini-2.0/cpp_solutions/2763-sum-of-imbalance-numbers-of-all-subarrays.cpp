#include <vector>

using namespace std;

class Solution {
public:
    int sumImbalanceNumbers(vector<int>& nums) {
        int n = nums.size();
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                vector<int> sub;
                for (int k = i; k <= j; ++k) {
                    sub.push_back(nums[k]);
                }
                sort(sub.begin(), sub.end());
                int imbalance = 0;
                for (int k = 1; k < sub.size(); ++k) {
                    if (sub[k] - sub[k - 1] > 1) {
                        imbalance++;
                    }
                }
                ans += imbalance;
            }
        }
        return ans;
    }
};