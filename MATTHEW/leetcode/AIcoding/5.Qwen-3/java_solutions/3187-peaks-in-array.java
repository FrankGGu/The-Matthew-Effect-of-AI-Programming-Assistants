public class Solution {
    public List<Integer> peaks(int[] nums) {
        List<Integer> result = new ArrayList<>();
        for (int i = 1; i < nums.length - 1; i++) {
            if (nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) {
                result.add(i);
            }
        }
        return result;
    }
}