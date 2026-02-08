import java.util.Arrays;

class Solution {

    private Boolean[][] memo;
    private int K_val;
    private int[] digits_arr;
    private int N_val;

    public boolean canBeDivisible(int[] digits, int k) {
        this.K_val = k;
        this.digits_arr = digits;
        this.N_val = digits.length;

        if (k == 1) {
            return true;
        }

        if (N_val == 1 && digits[0] == 0) {
            return true;
        }

        memo = new Boolean[1 << N_val][K_val];

        return solve(0, 0);
    }

    private boolean solve(int mask, int currentRemainder) {
        if (mask == (1 << N_val) - 1) {
            return currentRemainder == 0;
        }

        if (memo[mask][currentRemainder] != null) {
            return memo[mask][currentRemainder];
        }

        boolean possible = false;
        for (int i = 0; i < N_val; i++) {
            if ((mask & (1 << i)) == 0) {
                int digit = digits_arr[i];

                if (mask == 0 && digit == 0 && N_val > 1) {
                    continue;
                }

                int nextRemainder = (currentRemainder * 10 + digit) % K_val;
                int nextMask = mask | (1 << i);

                if (solve(nextMask, nextRemainder)) {
                    possible = true;
                    break;
                }
            }
        }

        memo[mask][currentRemainder] = possible;
        return possible;
    }
}