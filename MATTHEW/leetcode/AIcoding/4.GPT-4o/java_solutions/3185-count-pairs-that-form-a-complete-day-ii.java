class Solution {
    public int countPairs(int[] time) {
        int[] count = new int[60];
        int pairs = 0;

        for (int t : time) {
            t %= 60;
            pairs += count[(60 - t) % 60];
            count[t]++;
        }

        return pairs;
    }
}