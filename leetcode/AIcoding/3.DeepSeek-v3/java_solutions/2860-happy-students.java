class Solution {
    public int countWays(List<Integer> nums) {
        Collections.sort(nums);
        int n = nums.size();
        int ways = 0;

        if (nums.get(0) > 0) {
            ways++;
        }

        for (int i = 0; i < n - 1; i++) {
            int selected = i + 1;
            if (nums.get(i) < selected && nums.get(i + 1) > selected) {
                ways++;
            }
        }

        if (nums.get(n - 1) < n) {
            ways++;
        }

        return ways;
    }
}