class Solution {
public:
    int monkeyMove(int n) {
        const int MOD = 1e9 + 7;
        long long result = 1, base = 2;
        n = n - 2; // We need to count the collisions excluding the start and end positions

        while (n > 0) {
            if (n % 2 == 1) {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            n /= 2;
        }

        return (result - 2 + MOD) % MOD; // Subtracting 2 for the start and end positions
    }
};