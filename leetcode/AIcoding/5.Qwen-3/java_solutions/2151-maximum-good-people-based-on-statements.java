public class Solution {

import java.util.*;

public class Solution {
    public int maximumGood(String[] statements) {
        int n = statements.length;
        int maxGood = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            boolean valid = true;
            for (int i = 0; i < n && valid; i++) {
                if ((mask & (1 << i)) != 0) { // i is good
                    String s = statements[i];
                    for (int j = 0; j < n; j++) {
                        if (i != j) {
                            boolean isGoodJ = (mask & (1 << j)) != 0;
                            char c = s.charAt(j);
                            if (c == '0' && isGoodJ) {
                                valid = false;
                                break;
                            }
                            if (c == '1' && !isGoodJ) {
                                valid = false;
                                break;
                            }
                        }
                    }
                }
            }
            if (valid) {
                int count = Integer.bitCount(mask);
                maxGood = Math.max(maxGood, count);
            }
        }

        return maxGood;
    }
}
}