public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> smallerNumbersThanCurrent(int[] nums) {
        int[] copy = Arrays.copyOf(nums, nums.length);
        Arrays.sort(copy);
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < copy.length; i++) {
            if (!map.containsKey(copy[i])) {
                map.put(copy[i], i);
            }
        }
        List<Integer> result = new ArrayList<>();
        for (int num : nums) {
            result.add(map.get(num));
        }
        return result;
    }
}
}