class Solution {
    public int runeReserve(int[] runes) {
        Arrays.sort(runes);
        int maxLen = 1;
        int currentLen = 1;
        for (int i = 1; i < runes.length; i++) {
            if (runes[i] == runes[i - 1] + 1) {
                currentLen++;
            } else {
                maxLen = Math.max(maxLen, currentLen);
                currentLen = 1;
            }
        }
        return Math.max(maxLen, currentLen);
    }
}