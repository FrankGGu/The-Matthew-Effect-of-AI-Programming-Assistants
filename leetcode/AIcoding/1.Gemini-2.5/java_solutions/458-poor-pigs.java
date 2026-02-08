class Solution {
    public int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
        if (buckets == 1) {
            return 0;
        }

        int statesPerPig = minutesToTest / minutesToDie + 1;
        int pigs = 0;
        long totalStates = 1;

        while (totalStates < buckets) {
            totalStates *= statesPerPig;
            pigs++;
        }

        return pigs;
    }
}