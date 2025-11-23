class Solution {
    public int[] successfulPairs(int[] spells, int[] potions, long success) {
        Arrays.sort(potions);
        int[] res = new int[spells.length];
        for (int i = 0; i < spells.length; i++) {
            long minPotion = (success + spells[i] - 1) / spells[i];
            int left = 0, right = potions.length;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (potions[mid] < minPotion) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            res[i] = potions.length - left;
        }
        return res;
    }
}