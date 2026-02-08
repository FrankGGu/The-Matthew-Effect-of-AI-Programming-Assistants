class Solution {
    public String shiftingLetters(String s, int[] shifts) {
        int n = s.length();
        long[] prefixSum = new long[n];
        prefixSum[n - 1] = shifts[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            prefixSum[i] = prefixSum[i + 1] + shifts[i];
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            int shift = (int) (prefixSum[i] % 26);
            char c = s.charAt(i);
            int newChar = (c - 'a' + shift) % 26 + 'a';
            sb.append((char) newChar);
        }

        return sb.toString();
    }
}