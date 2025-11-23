class Solution {
    public int numPairsDivisibleBy60(int[] time) {
        int[] remainderCounts = new int[60];
        int count = 0;

        for (int t : time) {
            int remainder = t % 60;
            if (remainder == 0) {
                count += remainderCounts[0];
            } else {
                count += remainderCounts[60 - remainder];
            }
            remainderCounts[remainder]++;
        }

        return count;
    }
}