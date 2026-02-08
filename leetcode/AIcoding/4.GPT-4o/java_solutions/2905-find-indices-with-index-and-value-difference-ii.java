class Solution {
    public List<Integer> findIndices(int[] nums) {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (i + 2 == nums[i]) {
                result.add(i);
            }
        }
        return result;
    }
}