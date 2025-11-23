public class Solution {

import java.util.*;

public class Solution {
    public int maxTurbulenceSize(int[] arr) {
        int n = arr.length;
        if (n <= 1) return n;
        int maxLen = 1;
        int left = 0;
        for (int right = 1; right < n; right++) {
            if (arr[right] == arr[right - 1]) {
                left = right;
            } else if (right == 1 || (arr[right] > arr[right - 1] && arr[right - 1] < arr[right - 2]) || (arr[right] < arr[right - 1] && arr[right - 1] > arr[right - 2])) {
                maxLen = Math.max(maxLen, right - left + 1);
            } else {
                left = right - 1;
            }
        }
        return maxLen;
    }
}
}