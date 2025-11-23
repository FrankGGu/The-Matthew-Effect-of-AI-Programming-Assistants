public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> breakfastRotation(int[] arr) {
        List<List<Integer>> result = new ArrayList<>();
        int n = arr.length;
        int[] count = new int[n];
        for (int i = 0; i < n; i++) {
            count[i] = 1;
        }
        for (int i = 0; i < n; i++) {
            List<Integer> list = new ArrayList<>();
            for (int j = 0; j < n; j++) {
                list.add(arr[(i + j) % n]);
            }
            result.add(list);
            for (int j = 0; j < n; j++) {
                if (j == 0) {
                    count[j] = 1;
                } else {
                    if (arr[(i + j) % n] == arr[(i + j - 1) % n]) {
                        count[j] = count[j - 1] + 1;
                    } else {
                        count[j] = 1;
                    }
                }
            }
        }
        return result;
    }
}
}