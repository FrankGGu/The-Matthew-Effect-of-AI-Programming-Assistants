import java.util.*;

class Solution {
    public int[] recoverArray(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        for (int i = 1; i < n; ++i) {
            int k2 = nums[i] - nums[0];
            if (k2 == 0 || k2 % 2 != 0) {
                continue;
            }
            int k = k2 / 2;
            List<Integer> res = new ArrayList<>();
            boolean[] visited = new boolean[n];
            visited[i] = true;
            res.add(nums[0] + k);
            int left = 0, right = i;
            for (int j = 1; j < n / 2; ++j) {
                while (left < n && visited[left]) {
                    left++;
                }
                if (left >= n) {
                    break;
                }
                visited[left] = true;
                int target = nums[left] + 2 * k;
                while (right < n && (visited[right] || nums[right] < target)) {
                    right++;
                }
                if (right >= n || nums[right] != target) {
                    break;
                }
                visited[right] = true;
                res.add(nums[left] + k);
            }
            if (res.size() == n / 2) {
                return res.stream().mapToInt(Integer::intValue).toArray();
            }
        }
        return new int[0];
    }
}