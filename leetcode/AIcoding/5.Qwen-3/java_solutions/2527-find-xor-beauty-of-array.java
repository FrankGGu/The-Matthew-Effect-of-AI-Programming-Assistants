public class Solution {

import java.util.*;

public class Solution {
    public long[] xorBeauty(int[] arr) {
        int n = arr.length;
        long[] result = new long[n];
        long[] prefix = new long[n + 1];

        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] ^ arr[i];
        }

        for (int i = 0; i < n; ++i) {
            long total = 0;
            for (int j = 0; j <= i; ++j) {
                long left = prefix[j];
                long right = prefix[n] ^ prefix[i + 1];
                total ^= (left ^ right);
            }
            result[i] = total;
        }

        return result;
    }
}
}