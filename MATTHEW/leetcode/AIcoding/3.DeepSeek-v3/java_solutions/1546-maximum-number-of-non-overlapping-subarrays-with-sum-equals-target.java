class Solution {
    public int maxNonOverlapping(int[] nums, int target) {
        Set<Integer> set = new HashSet<>();
        set.add(0);
        int sum = 0;
        int count = 0;
        for (int num : nums) {
            sum += num;
            if (set.contains(sum - target)) {
                count++;
                set.clear();
                sum = 0;
            }
            set.add(sum);
        }
        return count;
    }
}