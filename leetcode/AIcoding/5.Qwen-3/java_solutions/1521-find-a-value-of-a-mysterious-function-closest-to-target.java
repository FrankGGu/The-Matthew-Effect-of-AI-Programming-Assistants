public class Solution {

import java.util.*;

public class Solution {
    public int closestToTarget(int[] arr, int target) {
        Set<Integer> set = new HashSet<>();
        int res = Integer.MAX_VALUE;
        for (int num : arr) {
            Set<Integer> newSet = new HashSet<>();
            newSet.add(num);
            for (int s : set) {
                newSet.add(s & num);
            }
            set = newSet;
            for (int s : set) {
                res = Math.min(res, Math.abs(s - target));
            }
        }
        return res;
    }
}
}