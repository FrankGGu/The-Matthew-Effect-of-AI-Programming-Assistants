import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumIncompatibility(int[] nums, int k) {
        int n = nums.length;
        int groupSize = n / k;
        Arrays.sort(nums);
        Map<Integer, Integer> memo = new HashMap<>();

        return solve(nums, 0, 0, new boolean[n], groupSize, memo);
    }

    private int solve(int[] nums, int index, int groupsFilled, boolean[] used, int groupSize, Map<Integer, Integer> memo) {
        if (index == nums.length) {
            return groupsFilled == nums.length / groupSize ? 0 : -1;
        }

        int state = getState(used);
        if (memo.containsKey(state)) {
            return memo.get(state);
        }

        if (used[index]) {
            return solve(nums, index + 1, groupsFilled, used, groupSize, memo);
        }

        int minIncompatibility = Integer.MAX_VALUE;
        for (int start = 0; start < nums.length; start++) {
            if (!used[start]) {
                int incompatibility = 0;
                boolean[] newUsed = used.clone();
                int[] group = new int[groupSize];
                int count = 0;
                int prev = -1;
                boolean valid = true;

                for (int i = 0; i < nums.length; i++) {
                    if (!newUsed[i]) {
                        group[count++] = nums[i];
                        newUsed[i] = true;
                        if (count > 1 && nums[i] == prev) {
                            valid = false;
                            break;
                        }
                        prev = nums[i];
                        if (count == groupSize) {
                            break;
                        }
                    }
                }

                if (count == groupSize && valid) {
                    incompatibility = group[groupSize - 1] - group[0];
                    int next = solve(nums, 0, groupsFilled + groupSize, newUsed, groupSize, memo);
                    if (next != -1) {
                        minIncompatibility = Math.min(minIncompatibility, incompatibility + next);
                    }
                }
            }
        }

        int result = (minIncompatibility == Integer.MAX_VALUE) ? -1 : minIncompatibility;
        memo.put(state, result);
        return result;
    }

    private int getState(boolean[] used) {
        int state = 0;
        for (int i = 0; i < used.length; i++) {
            if (used[i]) {
                state |= (1 << i);
            }
        }
        return state;
    }
}