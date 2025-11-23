import java.util.Arrays;

public class Solution {
    public int minOperations(int[] nums1, int[] nums2) {
        int sum1 = Arrays.stream(nums1).sum();
        int sum2 = Arrays.stream(nums2).sum();

        if (sum1 == sum2) return 0;

        int targetDiff = Math.abs(sum1 - sum2);
        int[] freq = new int[7];

        for (int num : nums1) {
            freq[Math.min(num, 6)]++;
        }

        for (int num : nums2) {
            freq[Math.min(num, 6)]++;
        }

        int operations = 0;
        for (int i = 6; i > 0 && targetDiff > 0; i--) {
            while (freq[i] > 0 && targetDiff > 0) {
                targetDiff -= i;
                freq[i]--;
                operations++;
            }
        }

        return targetDiff > 0 ? -1 : operations;
    }
}