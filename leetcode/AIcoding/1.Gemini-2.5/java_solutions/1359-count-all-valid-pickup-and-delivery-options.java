class Solution {
    public int countOrders(int n) {
        long ans = 1;
        long MOD = 1_000_000_007;

        for (int i = 2; i <= n; i++) {
            // For the i-th pair (Pi, Di), there are 2*(i-1) items already placed.
            // We need to place Pi and Di among these 2*(i-1) items, creating a total of 2*i items.
            // There are 2*i available positions in total.
            // We choose 2 positions for Pi and Di from these 2*i positions.
            // The number of ways to choose 2 positions is C(2*i, 2) = (2*i * (2*i - 1)) / 2 = i * (2*i - 1).
            // For each choice of 2 positions, Pi must be placed in the earlier position and Di in the later position
            // to satisfy the constraint that Pi comes before Di.
            // So, the number of ways to arrange i pairs given (i-1) pairs is f(i-1) * (i * (2*i - 1)).
            ans = (ans * i) % MOD;
            ans = (ans * (2L * i - 1)) % MOD; // Use 2L to ensure long multiplication for (2*i-1)
        }

        return (int) ans;
    }
}