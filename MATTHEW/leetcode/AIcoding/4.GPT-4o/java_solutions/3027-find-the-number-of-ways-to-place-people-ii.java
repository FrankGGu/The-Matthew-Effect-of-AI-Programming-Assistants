class Solution {
    public int countWays(int numPeople, int numSeats) {
        if (numPeople > numSeats) return 0;
        long mod = 1000000007;
        long result = 1;

        for (int i = 0; i < numPeople; i++) {
            result = (result * (numSeats - i)) % mod;
        }
        return (int) result;
    }
}