import java.util.Arrays;

public class Solution {
    public int maxSumRangeQuery(int[] nums, int[][] requests) {
        int n = nums.length;
        long[] count = new long[n];

        for (int[] req : requests) {
            count[req[0]]++;
            if (req[1] + 1 < n) {
                count[req[1] + 1]--;
            }
        }

        for (int i = 1; i < n; i++) {
            count[i] += count[i - 1];
        }

        Arrays.sort(nums);
        Arrays.sort(count);

        long result = 0;
        int mod = 1000000007;

        for (int i = 0; i < n; i++) {
            result = (result + (count[i] * nums[i]) % mod) % mod;
        }

        return (int) result;
    }
}