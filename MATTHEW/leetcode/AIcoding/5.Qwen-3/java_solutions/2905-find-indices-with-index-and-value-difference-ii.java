public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findIndices(int[] nums, int indexDifference, int valueDifference) {
        List<List<Integer>> result = new ArrayList<>();
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + indexDifference; j < n; j++) {
                if (Math.abs(nums[i] - nums[j]) >= valueDifference) {
                    List<Integer> pair = new ArrayList<>();
                    pair.add(i);
                    pair.add(j);
                    result.add(pair);
                    break;
                }
            }
        }
        return result;
    }
}
}