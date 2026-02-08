import java.util.Arrays;

class Solution {
    public boolean reorderedPowerOf2(int n) {
        int[] nCounts = countDigits(n);

        for (int i = 0; i < 31; i++) {
            int powerOf2 = 1 << i;
            int[] p2Counts = countDigits(powerOf2);
            if (Arrays.equals(nCounts, p2Counts)) {
                return true;
            }
        }

        return false;
    }

    private int[] countDigits(int num) {
        int[] counts = new int[10];
        while (num > 0) {
            counts[num % 10]++;
            num /= 10;
        }
        return counts;
    }
}