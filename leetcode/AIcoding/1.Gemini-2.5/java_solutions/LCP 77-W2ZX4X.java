import java.util.Arrays;

class Solution {

    public int runeReserve(int[] runes) {
        if (runes == null || runes.length == 0) {
            return 0;
        }

        Arrays.sort(runes);

        int maxCount = 0;
        if (runes.length > 0) {
            maxCount = 1; // A single rune always satisfies the condition (difference is 0)
        }

        int left = 0;
        for (int right = 0; right < runes.length; right++) {
            // Shrink the window from the left if the difference between the current rightmost
            // rune and the leftmost rune exceeds 2.
            while (runes[right] - runes[left] > 2) {
                left++;
            }
            // At this point, the window [left, right] is valid, meaning runes[right] - runes[left] <= 2.
            // Update maxCount with the length of the current valid window.
            maxCount = Math.max(maxCount, right - left + 1);
        }

        return maxCount;
    }
}