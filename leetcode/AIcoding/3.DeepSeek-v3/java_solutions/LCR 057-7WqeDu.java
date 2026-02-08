class Solution {
    public boolean containsNearbyAlmostDuplicate(int[] nums, int k, int t) {
        if (k < 1 || t < 0) return false;
        TreeSet<Long> set = new TreeSet<>();
        for (int i = 0; i < nums.length; i++) {
            long num = (long) nums[i];
            Long floor = set.floor(num + t);
            Long ceiling = set.ceiling(num - t);
            if ((floor != null && floor >= num) || (ceiling != null && ceiling <= num)) {
                return true;
            }
            set.add(num);
            if (i >= k) {
                set.remove((long) nums[i - k]);
            }
        }
        return false;
    }
}