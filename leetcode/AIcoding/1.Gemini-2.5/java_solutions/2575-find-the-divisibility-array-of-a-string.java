class Solution {
    public int[] divisibilityArray(String word, int m) {
        int n = word.length();
        int[] div = new int[n];
        long currentRemainder = 0;

        for (int i = 0; i < n; i++) {
            int digit = word.charAt(i) - '0';
            currentRemainder = (currentRemainder * 10 + digit) % m;
            if (currentRemainder == 0) {
                div[i] = 1;
            } else {
                div[i] = 0;
            }
        }

        return div;
    }
}