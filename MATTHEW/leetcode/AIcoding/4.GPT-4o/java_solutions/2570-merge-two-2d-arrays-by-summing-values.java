import java.util.*;

class Solution {
    public int[][] mergeArrays(int[][] nums1, int[][] nums2) {
        Map<Integer, Integer> map = new HashMap<>();

        for (int[] arr : nums1) {
            map.put(arr[0], map.getOrDefault(arr[0], 0) + arr[1]);
        }

        for (int[] arr : nums2) {
            map.put(arr[0], map.getOrDefault(arr[0], 0) + arr[1]);
        }

        List<int[]> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : map.entrySet()) {
            result.add(new int[]{entry.getKey(), entry.getValue()});
        }

        result.sort((a, b) -> Integer.compare(a[0], b[0]));

        return result.toArray(new int[result.size()][]);
    }
}