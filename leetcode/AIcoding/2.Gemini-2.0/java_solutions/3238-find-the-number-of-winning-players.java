import java.util.*;

class Solution {
    public List<List<Integer>> findWinners(int[][] matches) {
        Set<Integer> players = new HashSet<>();
        Map<Integer, Integer> losses = new HashMap<>();

        for (int[] match : matches) {
            int winner = match[0];
            int loser = match[1];

            players.add(winner);
            players.add(loser);

            losses.put(loser, losses.getOrDefault(loser, 0) + 1);
        }

        List<Integer> noLoss = new ArrayList<>();
        List<Integer> oneLoss = new ArrayList<>();

        for (int player : players) {
            if (!losses.containsKey(player)) {
                noLoss.add(player);
            } else if (losses.get(player) == 1) {
                oneLoss.add(player);
            }
        }

        Collections.sort(noLoss);
        Collections.sort(oneLoss);

        List<List<Integer>> result = new ArrayList<>();
        result.add(noLoss);
        result.add(oneLoss);

        return result;
    }
}