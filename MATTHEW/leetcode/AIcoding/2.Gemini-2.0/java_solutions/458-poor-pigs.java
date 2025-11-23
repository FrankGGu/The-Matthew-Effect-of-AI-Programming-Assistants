class Solution {
    public int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
        if (buckets == 1) {
            return 0;
        }
        int states = minutesToTest / minutesToDie + 1;
        int pigs = 0;
        while (Math.pow(states, pigs) < buckets) {
            pigs++;
        }
        return pigs;
    }
}