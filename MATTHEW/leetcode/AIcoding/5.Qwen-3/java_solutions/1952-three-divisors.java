public class Solution {

import java.util.*;

public class Solution {
    public boolean isThreeDivisors(long n) {
        if (n < 2) return false;
        int count = 0;
        for (long i = 1; i * i <= n; i++) {
            if (n % i == 0) {
                if (i * i == n) {
                    count++;
                } else {
                    count += 2;
                }
            }
        }
        return count == 3;
    }
}
}