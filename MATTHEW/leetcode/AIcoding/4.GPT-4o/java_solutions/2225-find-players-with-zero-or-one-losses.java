import java.util.*;

class Solution {
    public List<List<String>> findWinners(int[][] matches) {
        Map<String, Integer> lossCount = new HashMap<>();
        for (int[] match : matches) {
            lossCount.put(String.valueOf(match[0]), lossCount.getOrDefault(String.valueOf(match[0]), 0));
            lossCount.put(String.valueOf(match[1]), lossCount.getOrDefault(String.valueOf(match[1]), 0) + 1);
        }

        List<String> zeroLosses = new ArrayList<>();
        List<String> oneLoss = new ArrayList<>();

        for (Map.Entry<String, Integer> entry : lossCount.entrySet()) {
            if (entry.getValue() == 0) {
                zeroLosses.add(entry.getKey());
            } else if (entry.getValue() == 1) {
                oneLoss.add(entry.getKey());
            }
        }

        Collections.sort(zeroLosses);
        Collections.sort(oneLoss);

        List<List<String>> result = new ArrayList<>();
        result.add(zeroLosses);
        result.add(oneLoss);

        return result;
    }
}