import java.util.*;

class Solution {
    public int[] lexicographicallySmallestArray(int[] nums, int limit) {
        int n = nums.length;
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, Comparator.comparingInt(i -> nums[i]));

        int[] result = new int[n];
        boolean[] visited = new boolean[n];

        for (int i = 0; i < n; i++) {
            if (visited[i]) continue;

            List<Integer> groupIndices = new ArrayList<>();
            groupIndices.add(indices[i]);
            visited[i] = true;

            for (int j = i + 1; j < n; j++) {
                if (!visited[j] && Math.abs(nums[indices[i]] - nums[indices[j]]) <= limit) {
                    groupIndices.add(indices[j]);
                    visited[j] = true;
                }
            }

            List<Integer> groupValues = new ArrayList<>();
            for (int index : groupIndices) {
                groupValues.add(nums[index]);
            }
            Collections.sort(groupValues);
            Collections.sort(groupIndices);

            for (int k = 0; k < groupIndices.size(); k++) {
                result[groupIndices.get(k)] = groupValues.get(k);
            }
        }

        return result;
    }
}