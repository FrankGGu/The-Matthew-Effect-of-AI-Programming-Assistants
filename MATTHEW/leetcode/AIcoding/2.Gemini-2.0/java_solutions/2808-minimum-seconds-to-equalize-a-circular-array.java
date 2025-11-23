import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int minimumSeconds(List<Integer> nums) {
        int n = nums.size();
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int num = nums.get(i);
            map.computeIfAbsent(num, k -> new ArrayList<>()).add(i);
        }

        int minSeconds = Integer.MAX_VALUE;
        for (List<Integer> indices : map.values()) {
            int maxDiff = 0;
            for (int i = 0; i < indices.size(); i++) {
                int curr = indices.get(i);
                int next = indices.get((i + 1) % indices.size());
                int diff;
                if (next > curr) {
                    diff = next - curr;
                } else {
                    diff = next + n - curr;
                }
                maxDiff = Math.max(maxDiff, diff);
            }
            minSeconds = Math.min(minSeconds, maxDiff / 2);
        }

        return minSeconds;
    }
}