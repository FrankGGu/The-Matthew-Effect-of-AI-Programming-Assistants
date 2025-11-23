class Solution {
    public long countCompleteDayPairs(int[] hours) {
        long pairCount = 0;
        int[] remainderCounts = new int[24]; // Stores frequency of remainders when divided by 24

        for (int hour : hours) {
            int remainder = hour % 24;
            int complementRemainder = (24 - remainder) % 24;

            // Add the count of previously seen hours that form a complete day with the current hour
            pairCount += remainderCounts[complementRemainder];

            // Increment the count for the current hour's remainder
            remainderCounts[remainder]++;
        }

        return pairCount;
    }
}