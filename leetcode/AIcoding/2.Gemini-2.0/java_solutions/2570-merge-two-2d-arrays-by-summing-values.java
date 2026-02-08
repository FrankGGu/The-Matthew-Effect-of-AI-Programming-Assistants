import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

class Solution {
    public int[][] mergeArrays(int[][] nums1, int[][] nums2) {
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int[] num : nums1) {
            map.put(num[0], num[1]);
        }
        for (int[] num : nums2) {
            map.put(num[0], map.getOrDefault(num[0], 0) + num[1]);
        }

        List<Integer> keys = new ArrayList<>(map.keySet());
        Collections.sort(keys);

        int[][] result = new int[keys.size()][2];
        for (int i = 0; i < keys.size(); i++) {
            result[i][0] = keys.get(i);
            result[i][1] = map.get(keys.get(i));
        }
        return result;
    }
}