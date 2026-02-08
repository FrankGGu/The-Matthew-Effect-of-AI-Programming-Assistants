class Solution {
    public long maxTaxiEarnings(int n, int[][] rides) {
        Arrays.sort(rides, (a, b) -> a[1] - b[1]);
        TreeMap<Integer, Long> dp = new TreeMap<>();
        dp.put(0, 0L);
        long max = 0;
        for (int[] ride : rides) {
            int start = ride[0];
            int end = ride[1];
            int tip = ride[2];
            long currentEarning = end - start + tip;
            Long lowerKey = dp.floorKey(start);
            if (lowerKey != null) {
                currentEarning += dp.get(lowerKey);
            }
            if (currentEarning > max) {
                max = currentEarning;
                dp.put(end, max);
            }
        }
        return max;
    }
}