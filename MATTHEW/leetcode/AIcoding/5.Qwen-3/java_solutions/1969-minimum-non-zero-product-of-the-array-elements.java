public class Solution {

import java.util.*;

public class Solution {
    public int minNonZeroProduct(int k) {
        int mod = (int) (1e9 + 7);
        long max = (1L << k) - 1;
        long product = 1;
        for (long i = 2; i < max; i++) {
            product = (product * i) % mod;
        }
        return (int) product;
    }
}
}