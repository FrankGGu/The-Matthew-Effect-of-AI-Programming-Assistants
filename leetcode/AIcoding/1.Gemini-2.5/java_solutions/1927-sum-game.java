class Solution {
    public boolean sumGame(String num) {
        int n = num.length();
        int sum1 = 0;
        int q1 = 0;
        int sum2 = 0;
        int q2 = 0;

        for (int i = 0; i < n / 2; i++) {
            if (num.charAt(i) == '?') {
                q1++;
            } else {
                sum1 += (num.charAt(i) - '0');
            }
        }

        for (int i = n / 2; i < n; i++) {
            if (num.charAt(i) == '?') {
                q2++;
            } else {
                sum2 += (num.charAt(i) - '0');
            }
        }

        // The game is equivalent to Alice trying to make the final sum difference zero.
        // With optimal play, each '?' effectively contributes 4.5 (average of 0-9).
        // So, Alice wins if (sum1 + q1 * 4.5) == (sum2 + q2 * 4.5)
        // Rearranging this equation:
        // sum1 - sum2 == (q2 - q1) * 4.5
        // To avoid floating-point numbers, multiply by 2:
        // 2 * (sum1 - sum2) == (q2 - q1) * 9
        return (2 * (sum1 - sum2) == (q2 - q1) * 9);
    }
}