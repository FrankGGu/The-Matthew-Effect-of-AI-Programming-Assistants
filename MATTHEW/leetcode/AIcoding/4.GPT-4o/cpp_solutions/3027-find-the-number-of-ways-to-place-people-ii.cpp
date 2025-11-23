class Solution {
public:
    int countWays(int numPeople, int numSeats) {
        if (numPeople > numSeats) return 0;
        long long res = 1;
        for (int i = 0; i < numPeople; ++i) {
            res = res * (numSeats - i) % 1000000007;
        }
        return res;
    }
};