class Solution {
    public int findChampion(int n, int[][] battles) {
        boolean[] isDefeated = new boolean[n];

        for (int[] battle : battles) {
            int defeatedTeam = battle[1];
            isDefeated[defeatedTeam] = true;
        }

        int champion = -1;
        int championCount = 0;

        for (int i = 0; i < n; i++) {
            if (!isDefeated[i]) {
                champion = i;
                championCount++;
            }
        }

        if (championCount == 1) {
            return champion;
        } else {
            return -1;
        }
    }
}