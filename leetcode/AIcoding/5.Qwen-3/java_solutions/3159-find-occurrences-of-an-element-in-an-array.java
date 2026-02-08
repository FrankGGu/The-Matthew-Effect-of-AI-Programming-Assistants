public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> occurrencesOfElement(int[] nums, int x) {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == x) {
                result.add(i);
            }
        }
        return result;
    }
}
}