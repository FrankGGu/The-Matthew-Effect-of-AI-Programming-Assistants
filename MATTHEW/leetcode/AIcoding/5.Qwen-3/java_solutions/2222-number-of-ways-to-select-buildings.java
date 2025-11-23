public class Solution {
    public int numberOfWays(String s) {
        int n = s.length();
        int[] zeros = new int[n];
        int[] ones = new int[n];
        int countZero = 0;
        int countOne = 0;

        for (int i = 0; i < n; i++) {
            zeros[i] = countZero;
            ones[i] = countOne;
            if (s.charAt(i) == '0') {
                countZero++;
            } else {
                countOne++;
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '0') {
                result += ones[i] * (countOne - ones[i]);
            } else {
                result += zeros[i] * (countZero - zeros[i]);
            }
        }

        return result;
    }
}