class Solution {
    public int minimumIndex(int[] nums) {
        int n = nums.length;

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

        int total_freq = 0;
        for (int num : nums) {
            if (num == candidate) {
                total_freq++;
            }
        }

        if (total_freq * 2 <= n) {
            return -1;
        }

        int current_left_freq = 0;
        for (int i = 0; i < n - 1; i++) {
            if (nums[i] == candidate) {
                current_left_freq++;
            }

            int left_part_length = i + 1;
            int right_part_length = n - (i + 1);

            boolean is_left_dominant = (current_left_freq * 2 > left_part_length);
            boolean is_right_dominant = ((total_freq - current_left_freq) * 2 > right_part_length);

            if (is_left_dominant && is_right_dominant) {
                return i;
            }
        }

        return -1;
    }
}