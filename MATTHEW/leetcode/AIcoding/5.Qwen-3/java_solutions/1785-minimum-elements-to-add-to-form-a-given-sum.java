public class Solution {

import java.util.*;

public class Solution {
    public int minElements(List<Integer> nums, int limit, int goal) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        int diff = goal - sum;
        return (int) Math.ceil(Math.abs((double) diff / limit));
    }
}
}