class Solution {
    public int findWinningPlayers(int[][] players) {
        int winningPlayersCount = 0;
        for (int i = 0; i < players.length; i++) {
            if (players[i][0] > players[i][1]) {
                winningPlayersCount++;
            }
        }
        return winningPlayersCount;
    }
}