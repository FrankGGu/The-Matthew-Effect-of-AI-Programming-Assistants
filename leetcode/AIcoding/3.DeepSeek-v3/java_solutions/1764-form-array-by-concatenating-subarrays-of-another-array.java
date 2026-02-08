class Solution {
    public boolean canChoose(int[][] groups, int[] nums) {
        int i = 0;
        for (int[] group : groups) {
            boolean found = false;
            for (; i <= nums.length - group.length; i++) {
                if (matches(group, nums, i)) {
                    i += group.length;
                    found = true;
                    break;
                }
            }
            if (!found) return false;
        }
        return true;
    }

    private boolean matches(int[] group, int[] nums, int start) {
        for (int i = 0; i < group.length; i++) {
            if (group[i] != nums[start + i]) {
                return false;
            }
        }
        return true;
    }
}