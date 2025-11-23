class Solution {
    public boolean winnerOfGame(String colors) {
        int aCount = 0;
        int bCount = 0;
        for (int i = 1; i < colors.length() - 1; i++) {
            if (colors.charAt(i) == 'A' && colors.charAt(i - 1) == 'A' && colors.charAt(i + 1) == 'A') {
                aCount++;
            } else if (colors.charAt(i) == 'B' && colors.charAt(i - 1) == 'B' && colors.charAt(i + 1) == 'B') {
                bCount++;
            }
        }
        return aCount > bCount;
    }
}