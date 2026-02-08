class Solution {
    public int[] findWinners(int[][] matches) {
        Map<Integer, Integer> lossCount = new HashMap<>();

        for (int[] match : matches) {
            lossCount.put(match[0], lossCount.getOrDefault(match[0], 0));
            lossCount.put(match[1], lossCount.getOrDefault(match[1], 0) + 1);
        }

        List<Integer> winners = new ArrayList<>();
        List<Integer> oneLoss = new ArrayList<>();

        for (Map.Entry<Integer, Integer> entry : lossCount.entrySet()) {
            if (entry.getValue() == 0) {
                winners.add(entry.getKey());
            } else if (entry.getValue() == 1) {
                oneLoss.add(entry.getKey());
            }
        }

        Collections.sort(winners);
        Collections.sort(oneLoss);

        int[] result = new int[winners.size() + oneLoss.size()];
        int index = 0;

        for (int winner : winners) {
            result[index++] = winner;
        }
        for (int loser : oneLoss) {
            result[index++] = loser;
        }

        return result;
    }
}