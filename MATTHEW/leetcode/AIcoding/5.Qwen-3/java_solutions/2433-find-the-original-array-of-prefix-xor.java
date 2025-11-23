public class Solution {

import java.util.*;

public class Solution {
    public int[] findOriginalArray(int[] prefix) {
        int n = prefix.length;
        int[] result = new int[n];
        result[0] = prefix[0];
        for (int i = 1; i < n; i++) {
            result[i] = prefix[i] ^ prefix[i - 1];
        }
        return result;
    }
}
}