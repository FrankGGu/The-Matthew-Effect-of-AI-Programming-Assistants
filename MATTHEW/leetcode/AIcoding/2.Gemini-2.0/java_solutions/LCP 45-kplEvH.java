class Solution {
    public int bicycleYard(int[] position, int[][] bicycle) {
        int px = position[0];
        int py = position[1];

        int n = bicycle.length;
        int count = 0;

        for (int i = 0; i < n; i++) {
            int bx = bicycle[i][0];
            int by = bicycle[i][1];

            if ((bx - px) >= 0 && (by - py) >= 0 && (bx - px) + (by - py) > 0) {
                count++;
            }
        }

        return count;
    }
}