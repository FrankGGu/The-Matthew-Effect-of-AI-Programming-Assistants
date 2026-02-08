import java.util.Arrays;

class Solution {
    public int runeReserve(int[] runes) {
        if (runes.length == 0) {
            return 0;
        }
        Arrays.sort(runes);
        int max = 1;
        int current = 1;
        for (int i = 1; i < runes.length; i++) {
            if (runes[i] - runes[i - 1] <= 1) {
                current++;
                max = Math.max(max, current);
            } else {
                current = 1;
            }
        }
        return max;
    }
}