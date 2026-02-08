import java.util.*;

class Solution {
    public int[] recoverArray(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        for (int i = 1; i < n; i++) {
            if ((nums[i] - nums[0]) % 2 == 0) {
                int k = (nums[i] - nums[0]) / 2;
                if (k == 0) continue;
                List<Integer> lower = new ArrayList<>();
                List<Integer> upper = new ArrayList<>();
                Map<Integer, Integer> count = new HashMap<>();
                for (int num : nums) {
                    count.put(num, count.getOrDefault(num, 0) + 1);
                }
                boolean possible = true;
                for (int num : nums) {
                    if (count.get(num) == 0) continue;
                    count.put(num, count.get(num) - 1);
                    if (count.containsKey(num + 2 * k) && count.get(num + 2 * k) > 0) {
                        count.put(num + 2 * k, count.get(num + 2 * k) - 1);
                        lower.add(num + k);
                    } else {
                        possible = false;
                        break;
                    }
                }
                if (possible) {
                    int[] result = new int[n / 2];
                    for (int j = 0; j < n / 2; j++) {
                        result[j] = lower.get(j);
                    }
                    return result;
                }
            }
        }
        return new int[0];
    }
}