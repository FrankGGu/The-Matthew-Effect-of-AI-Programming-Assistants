class Solution {
    public int[] arrayChange(int[] nums, int[][] operations) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            map.put(nums[i], i);
        }
        for (int[] op : operations) {
            int oldVal = op[0];
            int newVal = op[1];
            int index = map.get(oldVal);
            nums[index] = newVal;
            map.remove(oldVal);
            map.put(newVal, index);
        }
        return nums;
    }
}