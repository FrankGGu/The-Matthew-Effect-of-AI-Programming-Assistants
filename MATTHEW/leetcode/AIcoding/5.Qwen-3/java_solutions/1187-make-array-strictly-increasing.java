public class Solution {

import java.util.*;

public class Solution {
    public int[] getAfterMoveArray(int[] arr) {
        int n = arr.length;
        int[] res = new int[n];
        res[0] = arr[0];
        for (int i = 1; i < n; i++) {
            if (arr[i] > res[i - 1]) {
                res[i] = arr[i];
            } else {
                res[i] = res[i - 1] + 1;
            }
        }
        return res;
    }
}
}