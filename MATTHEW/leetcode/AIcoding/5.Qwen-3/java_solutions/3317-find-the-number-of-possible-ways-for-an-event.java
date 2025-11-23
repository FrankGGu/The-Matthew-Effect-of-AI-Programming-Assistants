public class Solution {

import java.util.*;

public class Solution {
    public int numberOfWays(int n, int k) {
        if (n == 0) return 0;
        if (n == 1) return k;

        int same = k;
        int diff = k * (k - 1);

        for (int i = 2; i < n; i++) {
            int newDiff = (same + diff) * (k - 1);
            int newSame = diff * 1;
            same = newSame;
            diff = newDiff;
        }

        return same + diff;
    }
}
}