class Solution {
    public int numPairsDivisibleBy60(int[] time) {
        int[] count = new int[60];
        int result = 0;
        for (int t : time) {
            int remainder = t % 60;
            int complement = (60 - remainder) % 60;
            result += count[complement];
            count[remainder]++;
        }
        return result;
    }
}