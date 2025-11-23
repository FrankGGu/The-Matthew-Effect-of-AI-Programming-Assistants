public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findPlayersWithZeroOrOneLosses(List<List<Integer>> matches) {
        Map<Integer, Integer> lossCount = new HashMap<>();

        for (List<Integer> match : matches) {
            int player1 = match.get(0);
            int player2 = match.get(1);

            lossCount.put(player1, lossCount.getOrDefault(player1, 0));
            lossCount.put(player2, lossCount.getOrDefault(player2, 0) + 1);
        }

        List<Integer> zeroLosses = new ArrayList<>();
        List<Integer> oneLoss = new ArrayList<>();

        for (Map.Entry<Integer, Integer> entry : lossCount.entrySet()) {
            if (entry.getValue() == 0) {
                zeroLosses.add(entry.getKey());
            } else if (entry.getValue() == 1) {
                oneLoss.add(entry.getKey());
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
}