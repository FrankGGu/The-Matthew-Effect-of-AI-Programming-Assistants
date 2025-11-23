class Solution {
    public String getSmallestString(int n, int k) {
        char[] result = new char[n];
        for (int i = n - 1; i >= 0; i--) {
            int value = Math.min(26, k - i);
            result[i] = (char) ('a' + value - 1);
            k -= value;
        }
        return new String(result);
    }
}