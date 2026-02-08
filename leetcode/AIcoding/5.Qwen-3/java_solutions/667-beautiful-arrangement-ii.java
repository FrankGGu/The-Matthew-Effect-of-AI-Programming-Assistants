public class Solution {

import java.util.*;

public class Solution {
    public int[] constructArray(int n, int k) {
        int[] result = new int[n];
        int left = 1, right = n;
        int index = 0;
        while (left <= right) {
            if (index % 2 == 0) {
                result[index++] = left++;
            } else {
                result[index++] = right--;
            }
            if (index > k + 1) break;
        }
        return result;
    }
}
}