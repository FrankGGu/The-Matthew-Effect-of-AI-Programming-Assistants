class Solution {
    public String getSmallestString(int n, int k) {
        char[] result = new char[n];
        for (int i = 0; i < n; i++) {
            int remainingLength = n - 1 - i;
            int charValue = Math.max(1, k - remainingLength * 26);

            result[i] = (char) ('a' + charValue - 1);
            k -= charValue;
        }
        return new String(result);
    }
}