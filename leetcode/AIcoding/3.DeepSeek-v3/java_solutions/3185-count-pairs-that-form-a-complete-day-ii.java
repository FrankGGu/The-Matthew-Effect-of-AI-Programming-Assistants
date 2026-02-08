class Solution {
    public long countCompleteDayPairs(int[] hours) {
        Map<Integer, Integer> remainderCount = new HashMap<>();
        long count = 0;
        for (int hour : hours) {
            int remainder = hour % 24;
            int complement = (24 - remainder) % 24;
            count += remainderCount.getOrDefault(complement, 0);
            remainderCount.put(remainder, remainderCount.getOrDefault(remainder, 0) + 1);
        }
        return count;
    }
}