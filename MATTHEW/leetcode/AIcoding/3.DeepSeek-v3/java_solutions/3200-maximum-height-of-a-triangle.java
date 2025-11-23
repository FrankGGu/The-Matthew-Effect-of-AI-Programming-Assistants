class Solution {
    public int maxHeight(int[] sides) {
        Arrays.sort(sides);
        int n = sides.length;
        for (int i = n - 1; i >= 2; i--) {
            if (sides[i - 2] + sides[i - 1] > sides[i]) {
                return sides[i];
            }
        }
        return 0;
    }
}