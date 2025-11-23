public class Solution {
    public int[] sortJumbled(int[] mapping, int[][] nums) {
        int n = nums.length;
        int[][] mapped = new int[n][2];

        for (int i = 0; i < n; i++) {
            int original = nums[i];
            int mappedValue = 0;
            int power = 1;
            while (original > 0) {
                int digit = original % 10;
                mappedValue = mapping[digit] * power + mappedValue;
                original /= 10;
                power *= 10;
            }
            mapped[i][0] = mappedValue;
            mapped[i][1] = nums[i];
        }

        java.util.Arrays.sort(mapped, (a, b) -> a[0] - b[0]);

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = mapped[i][1];
        }

        return result;
    }
}