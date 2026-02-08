import java.util.Arrays;

public class Solution {
    public int matchPlayersAndTrainers(int[] players, int[] trainers) {
        Arrays.sort(players);
        Arrays.sort(trainers);
        int playerIndex = 0, trainerIndex = 0, matches = 0;

        while (playerIndex < players.length && trainerIndex < trainers.length) {
            if (players[playerIndex] <= trainers[trainerIndex]) {
                matches++;
                playerIndex++;
            }
            trainerIndex++;
        }

        return matches;
    }
}