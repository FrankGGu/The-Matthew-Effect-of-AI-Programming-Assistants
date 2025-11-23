public class Solution {

import java.util.*;

public class Solution {
    public int[] sortEvenOdd(int[] nums) {
        List<Integer> even = new ArrayList<>();
        List<Integer> odd = new ArrayList<>();

        for (int i = 0; i < nums.length; i++) {
            if (i % 2 == 0) {
                even.add(nums[i]);
            } else {
                odd.add(nums[i]);
            }
        }

        Collections.sort(even);
        Collections.sort(odd, Collections.reverseOrder());

        int[] result = new int[nums.length];
        int e = 0, o = 0;

        for (int i = 0; i < nums.length; i++) {
            if (i % 2 == 0) {
                result[i] = even.get(e++);
            } else {
                result[i] = odd.get(o++);
            }
        }

        return result;
    }
}
}