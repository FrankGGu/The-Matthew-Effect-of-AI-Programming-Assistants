class Solution {
    public int minimumRecolors(String blocks, int k) {
        int n = blocks.length();
        int minRecolors = Integer.MAX_VALUE;
        int blackCount = 0;

        for (int i = 0; i < n; i++) {
            if (i < k) {
                if (blocks.charAt(i) == 'B') {
                    blackCount++;
                }
            } else {
                if (blocks.charAt(i) == 'B') {
                    blackCount++;
                }
                if (blocks.charAt(i - k) == 'B') {
                    blackCount--;
                }
            }
            if (i >= k - 1) {
                minRecolors = Math.min(minRecolors, k - blackCount);
            }
        }
        return minRecolors;
    }
}