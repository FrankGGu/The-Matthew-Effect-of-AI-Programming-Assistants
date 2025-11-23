class Solution {
    public int countDifferentSubsequenceGCDs(int[] nums) {
        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }

        boolean[] present = new boolean[maxVal + 1];
        for (int num : nums) {
            present[num] = true;
        }

        int count = 0;
        for (int i = 1; i <= maxVal; i++) {
            int gcd = 0;
            for (int j = i; j <= maxVal; j += i) {
                if (present[j]) {
                    if (gcd == 0) {
                        gcd = j;
                    } else {
                        gcd = gcd(gcd, j);
                    }
                }
            }
            if (gcd == i) {
                count++;
            }
        }

        return count;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}