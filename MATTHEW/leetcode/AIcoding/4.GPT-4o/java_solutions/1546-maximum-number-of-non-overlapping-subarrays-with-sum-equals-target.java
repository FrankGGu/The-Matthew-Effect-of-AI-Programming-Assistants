import java.util.HashMap;

public class Solution {
    public int maxNonOverlapping(int[] nums, int target) {
        HashMap<Integer, Integer> map = new HashMap<>();
        map.put(0, -1);
        int sum = 0, count = 0, lastEnd = -1;

        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            if (map.containsKey(sum - target) && map.get(sum - target) >= lastEnd) {
                count++;
                lastEnd = i;
            }
            map.put(sum, i);
        }

        return count;
    }
}