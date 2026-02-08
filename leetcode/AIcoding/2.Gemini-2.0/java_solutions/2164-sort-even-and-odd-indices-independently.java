import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
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
        int evenIndex = 0;
        int oddIndex = 0;

        for (int i = 0; i < nums.length; i++) {
            if (i % 2 == 0) {
                result[i] = even.get(evenIndex++);
            } else {
                result[i] = odd.get(oddIndex++);
            }
        }

        return result;
    }
}