public class Solution {

import java.util.*;

public class Solution {
    public int[] supplyWagon(int[] supplies) {
        Arrays.sort(supplies);
        int n = supplies.length;
        int[] result = new int[n];
        int left = 0, right = n - 1;
        boolean flag = true;
        for (int i = 0; i < n; i++) {
            if (flag) {
                result[i] = supplies[left++];
            } else {
                result[i] = supplies[right--];
            }
            flag = !flag;
        }
        return result;
    }
}
}