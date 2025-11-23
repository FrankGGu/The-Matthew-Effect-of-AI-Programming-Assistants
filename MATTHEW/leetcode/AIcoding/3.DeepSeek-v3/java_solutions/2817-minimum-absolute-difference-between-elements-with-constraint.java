class Solution {
    public int minAbsoluteDifference(List<Integer> nums, int x) {
        TreeSet<Integer> set = new TreeSet<>();
        int minDiff = Integer.MAX_VALUE;
        for (int i = x; i < nums.size(); i++) {
            set.add(nums.get(i - x));
            Integer current = nums.get(i);
            Integer floor = set.floor(current);
            Integer ceiling = set.ceiling(current);
            if (floor != null) {
                minDiff = Math.min(minDiff, Math.abs(current - floor));
            }
            if (ceiling != null) {
                minDiff = Math.min(minDiff, Math.abs(current - ceiling));
            }
            if (minDiff == 0) {
                return 0;
            }
        }
        return minDiff;
    }
}