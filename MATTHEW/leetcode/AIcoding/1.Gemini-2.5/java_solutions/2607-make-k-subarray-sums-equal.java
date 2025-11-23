import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public long makeSubKSumEqual(int[] nums, int k) {
        int n = nums.length;
        long totalOperations = 0;
        boolean[] visited = new boolean[n];

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                List<Integer> group = new ArrayList<>();
                int currentIdx = i;

                // Traverse the cycle defined by currentIdx = (currentIdx + k) % n
                // All elements in this cycle must be equal to each other.
                while (!visited[currentIdx]) {
                    group.add(nums[currentIdx]);
                    visited[currentIdx] = true;
                    currentIdx = (currentIdx + k) % n;
                }

                // To minimize operations for this group, all elements should be changed to their median.
                Collections.sort(group);
                int median = group.get(group.size() / 2);

                for (int val : group) {
                    totalOperations += Math.abs(val - median);
                }
            }
        }

        return totalOperations;
    }
}