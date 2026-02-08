public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findKDistantIndices(List<Integer> nums, int k) {
        List<Integer> result = new ArrayList<>();
        int n = nums.size();
        Set<Integer> indices = new HashSet<>();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (Math.abs(i - j) <= k) {
                    indices.add(j);
                }
            }
        }

        for (int index : indices) {
            result.add(index);
        }

        Collections.sort(result);
        return result;
    }
}
}