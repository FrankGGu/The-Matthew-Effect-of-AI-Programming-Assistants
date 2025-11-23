public class Solution {

import java.util.*;

public class Solution {
    public int[] findArray(int[] subsetSums) {
        Arrays.sort(subsetSums);
        int n = subsetSums.length;
        int[] result = new int[n];
        int index = 0;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            if (subsetSums[i] != sum) {
                result[index++] = subsetSums[i] - sum;
                sum += result[index - 1];
            }
        }
        return result;
    }
}
}