public class Solution {
    public int splitArray(int[] nums, int m) {
        int left = 0;
        int right = 0;
        for (int num : nums) {
            left = Math.max(left, num);
            right += num;
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            int count = 1;
            int currentSum = 0;

            for (int num : nums) {
                currentSum += num;
                if (currentSum > mid) {
                    count++;
                    currentSum = num;
                    if (count > m) {
                        break;
                    }
                }
            }

            if (count > m) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }
}