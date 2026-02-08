import java.util.ArrayList;
import java.util.Collections;

class Solution {
    public int minimumRemoval(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        ArrayList<Integer> tails = new ArrayList<>();

        for (int num : nums) {
            int index = Collections.binarySearch(tails, num);

            if (index < 0) {
                index = -(index + 1);
            }

            if (index == tails.size()) {
                tails.add(num);
            } else {
                tails.set(index, num);
            }
        }

        return nums.length - tails.size();
    }
}