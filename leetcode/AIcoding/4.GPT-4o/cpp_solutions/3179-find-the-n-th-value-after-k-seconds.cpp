class Solution {
public:
    int getValueAfterKSeconds(int n, int k) {
        int cycle = 5; // Time taken for one complete cycle
        int cycleSum = 15; // Sum of values in one complete cycle (1+2+3+4+5)
        int completeCycles = k / cycle;
        int remainingSeconds = k % cycle;

        int result = completeCycles * cycleSum;

        for (int i = 1; i <= remainingSeconds; ++i) {
            result += i;
        }

        return result + n;
    }
};