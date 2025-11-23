class Solution {
    public int[] divisibilityArray(String word, int m) {
        int n = word.length();
        int[] result = new int[n];
        long remainder = 0;
        for (int i = 0; i < n; i++) {
            remainder = (remainder * 10 + (word.charAt(i) - '0')) % m;
            if (remainder == 0) {
                result[i] = 1;
            } else {
                result[i] = 0;
            }
        }
        return result;
    }
}