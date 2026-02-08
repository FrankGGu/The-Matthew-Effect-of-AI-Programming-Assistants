import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    int count = 0;

    public int numSquarefulPerms(int[] nums) {
        Arrays.sort(nums);
        List<Integer> list = new ArrayList<>();
        boolean[] used = new boolean[nums.length];
        permute(nums, list, used);
        return count;
    }

    private void permute(int[] nums, List<Integer> list, boolean[] used) {
        if (list.size() == nums.length) {
            count++;
            return;
        }

        for (int i = 0; i < nums.length; i++) {
            if (used[i] || (i > 0 && nums[i] == nums[i - 1] && !used[i - 1])) {
                continue;
            }

            if (list.size() > 0) {
                int sum = list.get(list.size() - 1) + nums[i];
                int sqrt = (int) Math.sqrt(sum);
                if (sqrt * sqrt != sum) {
                    continue;
                }
            }

            used[i] = true;
            list.add(nums[i]);
            permute(nums, list, used);
            list.remove(list.size() - 1);
            used[i] = false;
        }
    }
}