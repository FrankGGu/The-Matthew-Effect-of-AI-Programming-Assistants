#include <vector>
#include <numeric>

class Solution {
public:
    int minimumIndex(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 1) {
            return -1;
        }

        int candidate = -1;
        int count = 0;
        for (int num : nums) {
            if (count == 0) {
                candidate = num;
                count = 1;
            } else if (num == candidate) {
                count++;
            } else {
                count--;
            }
        }

        int total_dominant_count = 0;
        for (int num : nums) {
            if (num == candidate) {
                total_dominant_count++;
            }
        }

        if (total_dominant_count * 2 <= n) {
            return -1;
        }

        int current_left_dominant_count = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] == candidate) {
                current_left_dominant_count++;
            }

            int left_len = i + 1;
            int right_len = n - (i + 1);
            int current_right_dominant_count = total_dominant_count - current_left_dominant_count;

            bool is_left_dominant = (current_left_dominant_count * 2 > left_len);
            bool is_right_dominant = (current_right_dominant_count * 2 > right_len);

            if (is_left_dominant && is_right_dominant) {
                return i;
            }
        }

        return -1;
    }
};