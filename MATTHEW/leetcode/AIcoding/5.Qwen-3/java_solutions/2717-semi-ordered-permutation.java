public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> semiOrderedPermutation(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            indexMap.put(nums[i], i);
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            int pos = indexMap.get(i);
            if (pos != i - 1) {
                result.add(pos + 1);
                result.add(i - 1 + 1);
                int temp = nums[i - 1];
                nums[i - 1] = nums[pos];
                nums[pos] = temp;
                indexMap.put(nums[i - 1], i - 1);
                indexMap.put(nums[pos], pos);
            }
        }
        return result;
    }
}
}