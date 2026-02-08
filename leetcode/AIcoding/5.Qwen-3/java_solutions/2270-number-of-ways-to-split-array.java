public class Solution {
    public int numberOfWays(String s) {
        int n = s.length();
        int[] leftOnes = new int[n];
        int[] rightOnes = new int[n];

        int count = 0;
        for (int i = 0; i < n; i++) {
            leftOnes[i] = count;
            if (s.charAt(i) == '1') {
                count++;
            }
        }

        count = 0;
        for (int i = n - 1; i >= 0; i--) {
            rightOnes[i] = count;
            if (s.charAt(i) == '1') {
                count++;
            }
        }

        int result = 0;
        for (int i = 1; i < n - 1; i++) {
            if (s.charAt(i) == '0') {
                result += leftOnes[i] * rightOnes[i];
            }
        }

        return result;
    }
}