class Solution {
    public int[] shortestToChar(String s, char c) {
        int n = s.length();
        int[] result = new int[n];
        int lastPosition = -1;

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == c) {
                lastPosition = i;
            }
            result[i] = lastPosition == -1 ? Integer.MAX_VALUE : i - lastPosition;
        }

        lastPosition = -1;
        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == c) {
                lastPosition = i;
            }
            if (lastPosition != -1) {
                result[i] = Math.min(result[i], lastPosition - i);
            }
        }

        return result;
    }
}