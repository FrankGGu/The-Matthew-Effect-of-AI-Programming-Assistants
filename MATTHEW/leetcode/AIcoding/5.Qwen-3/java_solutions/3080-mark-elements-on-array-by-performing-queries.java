public class Solution {

import java.util.*;

public class Solution {
    public int[] markElements(int[] nums, int[] queries) {
        int n = nums.length;
        int[] result = new int[n];
        Arrays.fill(result, -1);
        Set<Integer> marked = new HashSet<>();
        for (int i = 0; i < queries.length; i++) {
            int index = queries[i];
            if (!marked.contains(index)) {
                marked.add(index);
                result[index] = i + 1;
            }
        }
        return result;
    }
}
}