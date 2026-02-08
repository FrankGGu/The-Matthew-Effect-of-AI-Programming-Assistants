import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] relativeSortArray(int[] arr1, int[] arr2) {
        Map<Integer, Integer> rank = new HashMap<>();
        for (int i = 0; i < arr2.length; i++) {
            rank.put(arr2[i], i);
        }

        Integer[] boxedArr1 = Arrays.stream(arr1).boxed().toArray(Integer[]::new);
        Arrays.sort(boxedArr1, (a, b) -> {
            if (rank.containsKey(a) && rank.containsKey(b)) {
                return rank.get(a) - rank.get(b);
            } else if (rank.containsKey(a)) {
                return -1;
            } else if (rank.containsKey(b)) {
                return 1;
            } else {
                return a - b;
            }
        });

        int[] result = new int[arr1.length];
        for (int i = 0; i < arr1.length; i++) {
            result[i] = boxedArr1[i];
        }

        return result;
    }
}