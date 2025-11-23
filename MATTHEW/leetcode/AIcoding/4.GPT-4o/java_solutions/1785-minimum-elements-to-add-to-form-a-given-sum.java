class Solution {
    public int minElements(int[] nums, int limit, int goal) {
        long sum = 0;
        for (int num : nums) {
            sum += num;
        }
        long diff = goal - sum;
        if (diff == 0) return 0;
        long add = Math.abs(diff);
        return (int) Math.ceil((double) add / limit);
    }
}