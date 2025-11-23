import java.util.*;

class Solution {
    public int minimumSeconds(List<Integer> nums) {
        int n = nums.size();
        Map<Integer, List<Integer>> pos = new HashMap<>();
        for (int i = 0; i < n; i++) {
            pos.computeIfAbsent(nums.get(i), k -> new ArrayList<>()).add(i);
        }

        int ans = n;
        for (List<Integer> indices : pos.values()) {
            int maxDiff = 0;
            for (int i = 1; i < indices.size(); i++) {
                maxDiff = Math.max(maxDiff, indices.get(i) - indices.get(i - 1) - 1);
            }
            maxDiff = Math.max(maxDiff, indices.get(0) + n - indices.get(indices.size() - 1) - 1);
            ans = Math.min(ans, (maxDiff + 1) / 2);
        }

        return ans;
    }
}