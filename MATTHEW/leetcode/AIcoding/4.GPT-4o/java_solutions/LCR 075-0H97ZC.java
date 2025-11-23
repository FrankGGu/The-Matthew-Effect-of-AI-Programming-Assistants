import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int[] relativeSortArray(int[] arr1, int[] arr2) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : arr1) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        int index = 0;
        for (int num : arr2) {
            while (countMap.get(num) > 0) {
                arr1[index++] = num;
                countMap.put(num, countMap.get(num) - 1);
            }
            countMap.remove(num);
        }

        int[] remaining = countMap.keySet().stream().mapToInt(num -> num).toArray();
        Arrays.sort(remaining);

        for (int num : remaining) {
            while (countMap.get(num) > 0) {
                arr1[index++] = num;
                countMap.put(num, countMap.get(num) - 1);
            }
        }

        return arr1;
    }
}