public class Solution {

import java.util.*;

public class Solution {
    public int monkeyMove(int n) {
        int MOD = 1000000007;
        long result = 1;
        long base = 2;
        while (n > 0) {
            if (n % 2 == 1) {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            n /= 2;
        }
        return (int) ((result - 1 + MOD) % MOD);
    }
}
}