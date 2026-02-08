class Solution {
    public int giveGem(int[] gem, int[][] operations) {
        for (int[] op : operations) {
            int x = op[0];
            int y = op[1];
            int give = gem[x] / 2;
            gem[x] -= give;
            gem[y] += give;
        }

        int min = Integer.MAX_VALUE;
        int max = Integer.MIN_VALUE;
        for (int g : gem) {
            min = Math.min(min, g);
            max = Math.max(max, g);
        }

        return max - min;
    }
}