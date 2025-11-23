class Solution {
    public int countDifferentSubsequenceGCDs(int[] nums) {
        int maxVal = 0;
        for (int num : nums) {
            if (num > maxVal) {
                maxVal = num;
            }
        }

        boolean[] present = new boolean[maxVal + 1];
        for (int num : nums) {
            present[num] = true;
        }

        int count = 0;
        for (int g = 1; g <= maxVal; g++) {
            int current_gcd_for_g = 0;
            for (int m = g; m <= maxVal; m += g) {
                if (present[m]) {
                    if (current_gcd_for_g == 0) {
                        current_gcd_for_g = m;
                    } else {
                        current_gcd_for_g = gcd(current_gcd_for_g, m);
                    }
                }
            }
            if (current_gcd_for_g == g) {
                count++;
            }
        }

        return count;
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