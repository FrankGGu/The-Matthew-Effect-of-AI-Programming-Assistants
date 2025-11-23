class Solution {
    public int minimumRecolors(String blocks, int k) {
        int n = blocks.length();
        int minRecolors = Integer.MAX_VALUE;

        for (int i = 0; i <= n - k; i++) {
            int recolors = 0;
            for (int j = i; j < i + k; j++) {
                if (blocks.charAt(j) == 'W') {
                    recolors++;
                }
            }
            minRecolors = Math.min(minRecolors, recolors);
        }

        return minRecolors;
    }
}