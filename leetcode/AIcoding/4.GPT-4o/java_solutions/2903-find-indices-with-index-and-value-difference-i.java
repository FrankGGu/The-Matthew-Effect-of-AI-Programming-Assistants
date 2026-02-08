class Solution {
    public List<Integer> findIndices(int[] nums) {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (i - nums[i] == 0) {
                result.add(i);
            }
        }
        return result;
    }
}