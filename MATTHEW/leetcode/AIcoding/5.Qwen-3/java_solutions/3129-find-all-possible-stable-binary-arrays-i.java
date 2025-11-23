public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findStableBinaryArrays(int n) {
        List<List<Integer>> result = new ArrayList<>();
        int[] array = new int[n];
        backtrack(array, 0, n, result);
        return result;
    }

    private void backtrack(int[] array, int index, int n, List<List<Integer>> result) {
        if (index == n) {
            List<Integer> list = new ArrayList<>();
            for (int num : array) {
                list.add(num);
            }
            result.add(list);
            return;
        }

        // Try placing 0
        array[index] = 0;
        backtrack(array, index + 1, n, result);

        // Try placing 1 only if it's valid
        if (index == 0 || array[index - 1] != 1) {
            array[index] = 1;
            backtrack(array, index + 1, n, result);
        }
    }
}
}