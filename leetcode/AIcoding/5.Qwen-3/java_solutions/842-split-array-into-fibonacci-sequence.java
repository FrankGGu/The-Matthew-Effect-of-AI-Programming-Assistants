public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> splitIntoFibonacci(int[] nums) {
        List<Integer> result = new ArrayList<>();
        backtrack(nums, 0, result);
        return result;
    }

    private boolean backtrack(int[] nums, int start, List<Integer> result) {
        if (start == nums.length) {
            return result.size() >= 3;
        }

        for (int i = start; i < nums.length; i++) {
            if (nums[start] == 0 && i > start) break;
            if (i > start && nums[start] == 0) continue;
            long num = 0;
            for (int j = start; j <= i; j++) {
                num = num * 10 + nums[j];
                if (num > Integer.MAX_VALUE) break;
            }
            if (num > Integer.MAX_VALUE) continue;
            int current = (int) num;
            if (result.size() >= 2) {
                int prev = result.get(result.size() - 1);
                int prevPrev = result.get(result.size() - 2);
                if (current > prev + prevPrev) break;
                if (current != prev + prevPrev) continue;
            }
            result.add(current);
            if (backtrack(nums, i + 1, result)) {
                return true;
            }
            result.remove(result.size() - 1);
        }
        return false;
    }
}
}