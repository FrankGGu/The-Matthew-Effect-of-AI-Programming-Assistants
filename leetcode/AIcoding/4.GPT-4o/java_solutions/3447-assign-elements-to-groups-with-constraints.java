import java.util.*;

class Solution {
    public boolean canFormGroups(int[] nums, int target) {
        int n = nums.length;
        if (n % target != 0) return false;

        int groupSize = n / target;
        Arrays.sort(nums);
        reverse(nums);

        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        return backtrack(count, groupSize, target, 0, 0);
    }

    private boolean backtrack(Map<Integer, Integer> count, int groupSize, int target, int currentSum, int groupsFormed) {
        if (groupsFormed == target) return true;
        if (currentSum == groupSize) return backtrack(count, groupSize, target, 0, groupsFormed + 1);

        for (int num : count.keySet()) {
            if (count.get(num) > 0) {
                int nextSum = currentSum + num;
                if (nextSum <= groupSize) {
                    count.put(num, count.get(num) - 1);
                    if (backtrack(count, groupSize, target, nextSum, groupsFormed)) return true;
                    count.put(num, count.get(num) + 1);
                }
            }
        }

        return false;
    }

    private void reverse(int[] nums) {
        for (int i = 0; i < nums.length / 2; i++) {
            int temp = nums[i];
            nums[i] = nums[nums.length - 1 - i];
            nums[nums.length - 1 - i] = temp;
        }
    }
}