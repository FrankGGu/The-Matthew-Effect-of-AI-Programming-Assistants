class Solution {
    public int[] divisibilityArray(String word, int m) {
        int n = word.length();
        int[] result = new int[n];
        long current = 0;

        for (int i = 0; i < n; i++) {
            current = (current * 10 + (word.charAt(i) - '0')) % m;
            result[i] = (current == 0) ? 1 : 0;
        }

        return result;
    }
}