public class Solution {

import java.util.*;

public class Solution {
    public int[] arrayRankTransform(int[] arr) {
        TreeSet<Integer> unique = new TreeSet<>();
        for (int num : arr) {
            unique.add(num);
        }

        Map<Integer, Integer> rankMap = new HashMap<>();
        int rank = 1;
        for (int num : unique) {
            rankMap.put(num, rank++);
        }

        int[] result = new int[arr.length];
        for (int i = 0; i < arr.length; i++) {
            result[i] = rankMap.get(arr[i]);
        }

        return result;
    }
}
}