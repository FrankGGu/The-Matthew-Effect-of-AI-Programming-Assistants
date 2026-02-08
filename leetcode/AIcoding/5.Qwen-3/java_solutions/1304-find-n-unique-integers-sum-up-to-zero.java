public class Solution {

import java.util.*;

public class Solution {
    public int[] sumZero(int n) {
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = i - n / 2;
        }
        return result;
    }
}
}