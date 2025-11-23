public class Solution {
    public int differentSubsequenceGCDs(int[] nums) {
        boolean[] seen = new boolean[10001];
        for (int num : nums) {
            seen[num] = true;
        }
        int result = 0;
        for (int i = 1; i <= 10000; ++i) {
            int gcd = 0;
            for (int j = i; j <= 10000; j += i) {
                if (seen[j]) {
                    gcd = gcd(gcd, j);
                }
            }
            if (gcd == i) {
                ++result;
            }
        }
        return result;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}