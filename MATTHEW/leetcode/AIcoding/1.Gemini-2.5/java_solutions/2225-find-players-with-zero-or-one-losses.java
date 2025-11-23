import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<List<Integer>> findWinners(int[][] matches) {
        Map<Integer, Integer> lossCounts = new HashMap<>();

        for (int[] match : matches) {
            int winner = match[0];
            int loser = match[1];

            lossCounts.putIfAbsent(winner, 0);
            lossCounts.put(loser, lossCounts.getOrDefault(loser, 0) + 1);
        }

        List<Integer> zeroLosses = new ArrayList<>();
        List<Integer> oneLoss = new ArrayList<>();

        for (Map.Entry<Integer, Integer> entry : lossCounts.entrySet()) {
            int player = entry.getKey();
            int losses = entry.getValue();

            if (losses == 0) {
                zeroLosses.add(player);
            } else if (losses == 1) {
                oneLoss.add(player);
            }
        }

        Collections.sort(zeroLosses);
        Collections.sort(oneLoss);

        List<List<Integer>> result = new ArrayList<>();
        result.add(zeroLosses);
        result.add(oneLoss);

        return result;
    }
}