public class Solution {

import java.util.*;

public class Solution {
    public int[][] mergeArrays(int[][] nums1, int[][] nums2) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int[] arr : nums1) {
            map.put(arr[0], map.getOrDefault(arr[0], 0) + arr[1]);
        }
        for (int[] arr : nums2) {
            map.put(arr[0], map.getOrDefault(arr[0], 0) + arr[1]);
        }
        int[][] result = new int[map.size()][2];
        int i = 0;
        for (Map.Entry<Integer, Integer> entry : map.entrySet()) {
            result[i][0] = entry.getKey();
            result[i][1] = entry.getValue();
            i++;
        }
        Arrays.sort(result, (a, b) -> a[0] - b[0]);
        return result;
    }
}
}