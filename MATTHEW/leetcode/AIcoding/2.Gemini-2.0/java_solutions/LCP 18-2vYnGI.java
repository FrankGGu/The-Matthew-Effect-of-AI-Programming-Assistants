import java.util.Arrays;

class Solution {
    public int breakfastNumber(int[] staple, int[] drinks, int x) {
        Arrays.sort(drinks);
        int count = 0;
        for (int s : staple) {
            int remaining = x - s;
            int left = 0, right = drinks.length - 1;
            int index = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (drinks[mid] <= remaining) {
                    index = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            if (index != -1) {
                count = (count + index + 1) % 1000000007;
            }
        }
        return count;
    }
}