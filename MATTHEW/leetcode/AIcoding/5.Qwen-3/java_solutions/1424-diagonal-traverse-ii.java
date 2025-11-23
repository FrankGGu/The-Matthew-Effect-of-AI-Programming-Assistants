public class Solution {

import java.util.*;

public class Solution {
    public int[] findDiagonalOrder(int[][] nums) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        int maxKey = 0;

        for (int i = 0; i < nums.length; i++) {
            for (int j = 0; j < nums[i].length; j++) {
                int key = i + j;
                map.putIfAbsent(key, new ArrayList<>());
                map.get(key).add(nums[i][j]);
                maxKey = Math.max(maxKey, key);
            }
        }

        int[] result = new int[totalElements(nums)];
        int index = 0;

        for (int i = 0; i <= maxKey; i++) {
            List<Integer> list = map.get(i);
            for (int j = list.size() - 1; j >= 0; j--) {
                result[index++] = list.get(j);
            }
        }

        return result;
    }

    private int totalElements(int[][] nums) {
        int count = 0;
        for (int[] row : nums) {
            count += row.length;
        }
        return count;
    }
}
}