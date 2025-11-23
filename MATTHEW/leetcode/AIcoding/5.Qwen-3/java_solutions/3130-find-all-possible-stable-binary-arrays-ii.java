public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> stableBinaryArrays(int n, int m) {
        List<List<Integer>> result = new ArrayList<>();
        int[] arr = new int[n];
        backtrack(arr, 0, n, m, result);
        return result;
    }

    private void backtrack(int[] arr, int index, int n, int m, List<List<Integer>> result) {
        if (index == n) {
            List<Integer> list = new ArrayList<>();
            for (int num : arr) {
                list.add(num);
            }
            result.add(list);
            return;
        }

        if (index > 0 && arr[index - 1] == 1 && arr[index - 2] == 1) {
            arr[index] = 0;
            backtrack(arr, index + 1, n, m, result);
        } else {
            arr[index] = 0;
            backtrack(arr, index + 1, n, m, result);
            if (index < n - 1 && arr[index + 1] != 1) {
                arr[index] = 1;
                backtrack(arr, index + 1, n, m, result);
            }
        }
    }
}
}