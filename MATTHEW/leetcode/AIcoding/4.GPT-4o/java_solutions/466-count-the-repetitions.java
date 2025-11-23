public class Solution {
    public int getMaxRepetitions(String s1, int n1, String s2, int n2) {
        int count = 0, i = 0, j = 0;
        int[] dp = new int[s1.length() + 1];
        int[] repeat = new int[s1.length() + 1];

        while (i < s1.length() && count < n1) {
            if (s1.charAt(i) == s2.charAt(j)) {
                j++;
                if (j == s2.length()) {
                    count++;
                    j = 0;
                }
            }
            i++;
            if (i == s1.length()) {
                dp[count] = i;
                repeat[count] = count;
                i = 0;
                count++;
            }
        }

        int total = 0, last = 0;
        for (int k = 0; k < count; k++) {
            if (repeat[k] > n1) break;
            last = k;
            total += repeat[k];
        }

        return total / n2;
    }
}