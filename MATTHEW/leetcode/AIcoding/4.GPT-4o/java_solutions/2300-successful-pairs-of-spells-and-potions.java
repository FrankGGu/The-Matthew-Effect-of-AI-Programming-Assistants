import java.util.Arrays;

class Solution {
    public int[] successfulPairs(int[] spells, int[] potions, long success) {
        int[] result = new int[spells.length];
        Arrays.sort(potions);

        for (int i = 0; i < spells.length; i++) {
            long required = (success + spells[i] - 1) / spells[i];
            int index = binarySearch(potions, required);
            result[i] = potions.length - index;
        }

        return result;
    }

    private int binarySearch(int[] potions, long required) {
        int left = 0, right = potions.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (potions[mid] < required) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}