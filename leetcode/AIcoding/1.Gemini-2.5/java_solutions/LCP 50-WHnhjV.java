class Solution {
    public int gemSupply(int[] gems, int[][] operations) {
        for (int[] op : operations) {
            int from = op[0];
            int to = op[1];
            int movedGems = gems[from] / 2;
            gems[from] -= movedGems;
            gems[to] += movedGems;
        }

        int minGems = Integer.MAX_VALUE;
        int maxGems = Integer.MIN_VALUE;

        for (int gemCount : gems) {
            if (gemCount < minGems) {
                minGems = gemCount;
            }
            if (gemCount > maxGems) {
                maxGems = gemCount;
            }
        }

        return maxGems - minGems;
    }
}