public class Solution {

import java.util.List;

public class Solution {
    public int averageValue(List<Integer> nums) {
        int sum = 0;
        int count = 0;
        for (int num : nums) {
            if (num % 6 == 0) {
                sum += num;
                count++;
            }
        }
        return count == 0 ? 0 : sum / count;
    }
}
}