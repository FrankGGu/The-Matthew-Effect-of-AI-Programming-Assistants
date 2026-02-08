#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums, int x) {
        int n = nums.size();
        vector<long long> dp_even(n, -1);
        vector<long long> dp_odd(n, -1);

        if (nums[0] % 2 == 0) {
            dp_even[0] = nums[0];
            dp_odd[0] = -1;
        } else {
            dp_odd[0] = nums[0];
            dp_even[0] = -1;
        }

        for (int i = 1; i < n; ++i) {
            if (nums[i] % 2 == 0) {
                if (dp_even[i - 1] != -1) {
                    dp_even[i] = dp_even[i - 1] + nums[i];
                }
                if (dp_odd[i - 1] != -1) {
                    dp_even[i] = max(dp_even[i], dp_odd[i - 1] - x + nums[i]);
                }
                dp_odd[i] = dp_odd[i - 1];
            } else {
                if (dp_odd[i - 1] != -1) {
                    dp_odd[i] = dp_odd[i - 1] + nums[i];
                }
                if (dp_even[i - 1] != -1) {
                    dp_odd[i] = max(dp_odd[i], dp_even[i - 1] - x + nums[i]);
                }
                dp_even[i] = dp_even[i - 1];
            }
        }

        return max(dp_even[n - 1], dp_odd[n - 1]);
    }
};