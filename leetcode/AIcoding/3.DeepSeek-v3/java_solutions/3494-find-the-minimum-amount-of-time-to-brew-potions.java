class Solution {
    public int minTimeToBrew(int[] potions, int k) {
        int left = 1;
        int right = Arrays.stream(potions).max().getAsInt();
        int result = right;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canBrew(potions, mid, k)) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return result;
    }

    private boolean canBrew(int[] potions, int time, int k) {
        long total = 0;
        for (int potion : potions) {
            total += time / potion;
            if (total >= k) {
                return true;
            }
        }
        return total >= k;
    }
}