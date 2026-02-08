class Solution {
    public int findWinningPlayer(int[] skills, int k) {
        int n = skills.length;
        int max = 0;
        for (int num : skills) {
            max = Math.max(max, num);
        }

        int currentWinner = 0;
        int consecutiveWins = 0;

        for (int i = 1; i < n; i++) {
            if (skills[currentWinner] > skills[i]) {
                consecutiveWins++;
            } else {
                currentWinner = i;
                consecutiveWins = 1;
            }

            if (consecutiveWins == k || skills[currentWinner] == max) {
                return currentWinner;
            }
        }

        return currentWinner;
    }
}