import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int[] relativeSortArray(int[] arr1, int[] arr2) {
        Map<Integer, Integer> rank = new HashMap<>();
        for (int i = 0; i < arr2.length; i++) {
            rank.put(arr2[i], i);
        }

        List<Integer> remaining = new ArrayList<>();
        for (int num : arr1) {
            if (!rank.containsKey(num)) {
                remaining.add(num);
            }
        }

        Arrays.sort(remaining.toArray(new Integer[0]));

        int[] result = new int[arr1.length];
        int index = 0;
        for (int num : arr2) {
            for (int i = 0; i < arr1.length; i++) {
                if (arr1[i] == num) {
                    result[index++] = num;
                }
            }
        }

        for (int num : remaining) {
            result[index++] = num;
        }

        return result;
    }
}