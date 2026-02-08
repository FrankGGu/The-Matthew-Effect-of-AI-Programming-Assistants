class Solution {
    public int numberOfWays(String corridor) {
        int MOD = 1_000_000_007;
        int seats = 0;
        int plants = 0;
        long result = 1;

        for (char c : corridor.toCharArray()) {
            if (c == 'S') {
                seats++;
                if (seats % 2 == 0) {
                    result = (result * (plants + 1)) % MOD;
                    plants = 0;
                }
            } else {
                if (seats > 0 && seats % 2 == 0) {
                    plants++;
                }
            }
        }

        return (seats % 2 != 0 || seats == 0) ? 0 : (int) result;
    }
}