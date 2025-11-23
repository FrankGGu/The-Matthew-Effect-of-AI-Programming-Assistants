class Solution {
    public int minimumCardPickup(int[] cards) {
        Map<Integer, Integer> indexMap = new HashMap<>();
        int minLength = Integer.MAX_VALUE;

        for (int i = 0; i < cards.length; i++) {
            if (indexMap.containsKey(cards[i])) {
                minLength = Math.min(minLength, i - indexMap.get(cards[i]) + 1);
            }
            indexMap.put(cards[i], i);
        }

        return minLength == Integer.MAX_VALUE ? -1 : minLength;
    }
}