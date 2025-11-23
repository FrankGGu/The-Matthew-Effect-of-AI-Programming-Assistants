class Solution {
    public int numberOfWays(String corridor) {
        long ways = 1;
        int seatCount = 0;
        int lastSeatIndex = -1;
        int MOD = 1_000_000_007;

        for (int i = 0; i < corridor.length(); i++) {
            if (corridor.charAt(i) == 'S') {
                seatCount++;
                if (seatCount > 2 && seatCount % 2 != 0) {
                    int plantsBetween = i - lastSeatIndex - 1;
                    ways = (ways * (plantsBetween + 1)) % MOD;
                }
                lastSeatIndex = i;
            }
        }

        if (seatCount == 0 || seatCount % 2 != 0) {
            return 0;
        }

        return (int) ways;
    }
}