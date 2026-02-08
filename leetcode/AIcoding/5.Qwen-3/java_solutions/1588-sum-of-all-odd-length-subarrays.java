public class Solution {

import java.util.*;

public class Solution {
    public int sumOddLengthSubarrays(int[] arr) {
        int n = arr.length;
        int total = 0;
        for (int i = 0; i < n; i++) {
            int count = ((n - i) * (i + 1) + 1) / 2;
            total += arr[i] * count;
        }
        return total;
    }
}
}