class Solution {
    public int minimumCardPickup(int[] cards) {
        Map<Integer, Integer> lastIndex = new HashMap<>();
        int minDistance = Integer.MAX_VALUE;

        for (int i = 0; i < cards.length; i++) {
            if (lastIndex.containsKey(cards[i])) {
                int distance = i - lastIndex.get(cards[i]) + 1;
                if (distance < minDistance) {
                    minDistance = distance;
                }
            }
            lastIndex.put(cards[i], i);
        }

        return minDistance == Integer.MAX_VALUE ? -1 : minDistance;
    }
}