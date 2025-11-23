class Solution {
    public int minimumRecolors(String blocks, int k) {
        int minRecolors = Integer.MAX_VALUE;
        int whiteCount = 0;

        for (int i = 0; i < blocks.length(); i++) {
            if (blocks.charAt(i) == 'W') {
                whiteCount++;
            }

            if (i >= k - 1) {
                if (i >= k) {
                    if (blocks.charAt(i - k) == 'W') {
                        whiteCount--;
                    }
                }
                minRecolors = Math.min(minRecolors, whiteCount);
            }
        }

        return minRecolors;
    }
}