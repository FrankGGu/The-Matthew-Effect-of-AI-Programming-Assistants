class Solution {
    public String findChampion(String[] players) {
        Map<String, Integer> scoreMap = new HashMap<>();
        for (String player : players) {
            scoreMap.put(player, scoreMap.getOrDefault(player, 0) + 1);
        }
        String champion = "";
        int maxScore = 0;
        for (Map.Entry<String, Integer> entry : scoreMap.entrySet()) {
            if (entry.getValue() > maxScore) {
                maxScore = entry.getValue();
                champion = entry.getKey();
            }
        }
        return champion;
    }
}