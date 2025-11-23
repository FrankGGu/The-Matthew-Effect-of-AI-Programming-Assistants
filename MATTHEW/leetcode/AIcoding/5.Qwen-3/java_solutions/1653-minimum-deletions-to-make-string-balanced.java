public class Solution {
    public int minimumDeletions(String s) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];

        int count = 0;
        for (int i = 0; i < n; i++) {
            left[i] = count;
            if (s.charAt(i) == 'b') {
                count++;
            }
        }

        count = 0;
        for (int i = n - 1; i >= 0; i--) {
            right[i] = count;
            if (s.charAt(i) == 'a') {
                count++;
            }
        }

        int min = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            min = Math.min(min, left[i] + right[i]);
        }

        return min;
    }
}