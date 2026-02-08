#include <vector>

class Solution {
public:
    long long minimumOperations(std::vector<int>& nums, std::vector<int>& target) {
        int n = nums.size();
        long long inc = 0;
        long long dec = 0;
        long long prev_pos = 0;
        long long prev_neg = 0;

        for (int i = 0; i < n; ++i) {
            long long diff = (long long)target[i] - nums[i];

            long long curr_pos = 0;
            long long curr_neg = 0;

            if (diff > 0) {
                curr_pos = diff;
            } else {
                curr_neg = -diff;
            }

            if (curr_pos > prev_pos) {
                inc += curr_pos - prev_pos;
            }

            if (curr_neg > prev_neg) {
                dec += curr_neg - prev_neg;
            }

            prev_pos = curr_pos;
            prev_neg = curr_neg;
        }

        return inc + dec;
    }
};