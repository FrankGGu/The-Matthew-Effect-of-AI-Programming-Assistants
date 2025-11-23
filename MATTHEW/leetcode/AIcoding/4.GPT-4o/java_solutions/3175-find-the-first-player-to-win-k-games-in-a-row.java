import java.util.HashMap;
import java.util.Map;

public class Solution {
    public String findWinner(String[] players, int k) {
        Map<String, Integer> playerWins = new HashMap<>();
        Map<String, Integer> playerStreak = new HashMap<>();

        for (String player : players) {
            playerWins.put(player, playerWins.getOrDefault(player, 0) + 1);
            playerStreak.put(player, playerStreak.getOrDefault(player, 0) + 1);

            if (playerStreak.get(player) == k) {
                return player;
            }

            for (String p : playerWins.keySet()) {
                if (!p.equals(player)) {
                    playerStreak.put(p, 0);
                }
            }
        }
        return "";
    }
}