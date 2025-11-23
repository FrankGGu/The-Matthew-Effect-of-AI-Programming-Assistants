class Solution {
    public double minimumAverage(int[] nums) {
        Arrays.sort(nums);
        double smallest = nums[0];
        double largest = nums[nums.length - 1];
        return (smallest + largest) / 2.0;
    }
}