public class Solution {
    public int[] findWinners(int[][] matches) {
        Map<Integer, Integer> lossCount = new HashMap<>();
        Set<Integer> players = new HashSet<>();

        for (int[] match : matches) {
            players.add(match[0]);
            players.add(match[1]);
            lossCount.put(match[1], lossCount.getOrDefault(match[1], 0) + 1);
            lossCount.putIfAbsent(match[0], 0);
        }

        List<Integer> winners = new ArrayList<>();
        List<Integer> oneLoss = new ArrayList<>();

        for (int player : players) {
            if (lossCount.get(player) == 0) {
                winners.add(player);
            } else if (lossCount.get(player) == 1) {
                oneLoss.add(player);
            }
        }

        Collections.sort(winners);
        Collections.sort(oneLoss);

        List<Integer> result = new ArrayList<>(winners);
        result.addAll(oneLoss);

        return result.stream().mapToInt(i -> i).toArray();
    }
}