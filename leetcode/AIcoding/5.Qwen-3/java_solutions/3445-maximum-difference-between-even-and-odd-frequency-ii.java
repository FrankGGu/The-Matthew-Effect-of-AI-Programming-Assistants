public class Solution {

import java.util.*;

public class Solution {
    public int oddEvenJumps(int[] arr) {
        int n = arr.length;
        boolean[] canReachOdd = new boolean[n];
        boolean[] canReachEven = new boolean[n];
        canReachOdd[n - 1] = true;
        canReachEven[n - 1] = true;

        TreeMap<Integer, Integer> map = new TreeMap<>();
        map.put(arr[n - 1], n - 1);

        for (int i = n - 2; i >= 0; i--) {
            Integer nextHigher = map.ceilingKey(arr[i]);
            if (nextHigher != null) {
                int index = map.get(nextHigher);
                canReachEven[i] = canReachOdd[index];
            }

            Integer nextLower = map.floorKey(arr[i]);
            if (nextLower != null) {
                int index = map.get(nextLower);
                canReachOdd[i] = canReachEven[index];
            }

            map.put(arr[i], i);
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            if (canReachOdd[i]) {
                result++;
            }
        }
        return result;
    }
}
}