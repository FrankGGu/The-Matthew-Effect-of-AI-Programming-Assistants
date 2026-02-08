public class Solution {

import java.util.Arrays;

public class Solution {
    public int[] successfulPairs(int[] spells, int[] potions, long success) {
        int n = spells.length;
        int m = potions.length;
        int[] result = new int[n];
        Arrays.sort(potions);

        for (int i = 0; i < n; i++) {
            long target = (success + spells[i] - 1) / spells[i]; // Ceiling division
            int left = 0;
            int right = m;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if ((long) potions[mid] * spells[i] >= success) {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            result[i] = m - left;
        }

        return result;
    }
}
}