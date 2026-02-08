import java.util.Arrays;

public class Solution {
    public int minDeletions(int[] nums, int[] divisors) {
        Arrays.sort(nums);
        Arrays.sort(divisors);
        int n = nums.length;
        int m = divisors.length;
        int deletions = 0;

        for (int i = 0; i < n; i++) {
            boolean found = false;
            for (int j = 0; j < m; j++) {
                if (nums[i] % divisors[j] == 0) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                deletions++;
            }
        }

        return deletions;
    }
}