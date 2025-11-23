#include <vector>
#include <algorithm>

class Solution {
public:
    int getMaxLen(std::vector<int>& nums) {
        int max_len = 0;
        int current_pos_len = 0; // length of longest subarray ending here with positive product
        int current_neg_len = 0; // length of longest subarray ending here with negative product

        for (int num : nums) {
            if (num > 0) {
                current_pos_len++;
                if (current_neg_len > 0) {
                    current_neg_len++;
                } else {
                    current_neg_len = 0; // No negative product subarray could become negative by multiplying a positive
                }
            } else if (num < 0) {
                int prev_pos_len = current_pos_len;
                int prev_neg_len = current_neg_len;

                // A negative number times a negative product becomes a positive product
                current_pos_len = (prev_neg_len > 0) ? prev_neg_len + 1 : 0;

                // A negative number times a positive product becomes a negative product
                // Or a single negative number starts a negative product subarray of length 1
                current_neg_len = prev_pos_len + 1;
            } else { // num == 0
                current_pos_len = 0;
                current_neg_len = 0;
            }
            max_len = std::max(max_len, current_pos_len);
        }

        return max_len;
    }
};