class Solution {
    public List<List<Integer>> findWinners(int[][] matches) {
        Map<Integer, Integer> lossCount = new HashMap<>();
        Set<Integer> players = new HashSet<>();

        for (int[] match : matches) {
            int winner = match[0];
            int loser = match[1];
            players.add(winner);
            players.add(loser);
            lossCount.put(loser, lossCount.getOrDefault(loser, 0) + 1);
        }

        List<Integer> zeroLoss = new ArrayList<>();
        List<Integer> oneLoss = new ArrayList<>();

        for (int player : players) {
            int losses = lossCount.getOrDefault(player, 0);
            if (losses == 0) {
                zeroLoss.add(player);
            } else if (losses == 1) {
                oneLoss.add(player);
            }
        }

        Collections.sort(zeroLoss);
        Collections.sort(oneLoss);

        List<List<Integer>> result = new ArrayList<>();
        result.add(zeroLoss);
        result.add(oneLoss);

        return result;
    }
}