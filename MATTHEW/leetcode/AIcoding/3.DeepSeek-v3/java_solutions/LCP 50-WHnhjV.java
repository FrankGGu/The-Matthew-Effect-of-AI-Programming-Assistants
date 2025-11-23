class Solution {
    public int giveGem(int[] gem, int[][] operations) {
        for (int[] op : operations) {
            int x = op[0];
            int y = op[1];
            int give = gem[x] / 2;
            gem[x] -= give;
            gem[y] += give;
        }
        int max = Integer.MIN_VALUE;
        int min = Integer.MAX_VALUE;
        for (int num : gem) {
            if (num > max) {
                max = num;
            }
            if (num < min) {
                min = num;
            }
        }
        return max - min;
    }
}