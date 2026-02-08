import java.util.ArrayList;
import java.util.List;

class Solution {
    public int countHillValley(int[] nums) {
        List<Integer> distinctNums = new ArrayList<>();
        distinctNums.add(nums[0]);

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] != nums[i - 1]) {
                distinctNums.add(nums[i]);
            }
        }

        if (distinctNums.size() < 3) {
            return 0;
        }

        int count = 0;
        for (int i = 1; i < distinctNums.size() - 1; i++) {
            int prev = distinctNums.get(i - 1);
            int curr = distinctNums.get(i);
            int next = distinctNums.get(i + 1);

            // Check for hill
            if (prev < curr && curr > next) {
                count++;
            }
            // Check for valley
            else if (prev > curr && curr < next) {
                count++;
            }
        }

        return count;
    }
}