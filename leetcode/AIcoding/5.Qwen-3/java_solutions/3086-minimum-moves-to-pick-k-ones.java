public class Solution {

import java.util.*;

public class Solution {
    public int minMovesToPickKOnes(int[] nums, int k) {
        List<Integer> ones = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                ones.add(i);
            }
        }
        int n = ones.size();
        int result = Integer.MAX_VALUE;
        for (int i = 0; i + k - 1 < n; i++) {
            int left = ones.get(i);
            int right = ones.get(i + k - 1);
            int mid = ones.get(i + (k - 1) / 2);
            int moves = 0;
            for (int j = i; j <= i + k - 1; j++) {
                moves += Math.abs(ones.get(j) - mid);
            }
            result = Math.min(result, moves);
        }
        return result;
    }
}
}