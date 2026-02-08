import java.util.List;

class Solution {
    public int findLength(List<Integer> nums) {
        int count = 0;
        for (int num : nums) {
            if (num > 0) {
                count++;
            }
        }
        return count;
    }
}