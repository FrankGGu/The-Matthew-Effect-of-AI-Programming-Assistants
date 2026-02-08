public class Solution {

import java.util.*;

public class Solution {
    public int minNumberOperations(int[] target) {
        int res = 0;
        for (int i = 0; i < target.length; i++) {
            if (i == 0 || target[i] > target[i - 1]) {
                res += target[i] - target[i - 1];
            }
        }
        return res;
    }
}
}