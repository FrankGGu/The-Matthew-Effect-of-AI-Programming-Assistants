import java.util.*;

public class Solution {
    public List<Integer> nextGreater(nums, target) {
        int n = nums.length;
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            if (!map.containsKey(nums[i])) {
                map.put(nums[i], new ArrayList<>());
            }
            map.get(nums[i]).add(i);
        }

        int[] res = new int[n];
        Stack<Integer> stack = new Stack<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && nums[stack.peek()] < nums[i]) {
                res[stack.pop()] = nums[i];
            }
            stack.push(i);
        }

        while (!stack.isEmpty()) {
            res[stack.pop()] = -1;
        }

        List<Integer> result = new ArrayList<>();
        for (int t : target) {
            result.add(res[map.get(t).get(0)]);
        }

        return result;
    }
}