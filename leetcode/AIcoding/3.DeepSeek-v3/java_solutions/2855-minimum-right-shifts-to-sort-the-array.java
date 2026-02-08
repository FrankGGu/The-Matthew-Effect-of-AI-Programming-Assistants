class Solution {
    public int minimumRightShifts(List<Integer> nums) {
        int n = nums.size();
        int pivot = 0;
        for (int i = 1; i < n; i++) {
            if (nums.get(i) < nums.get(i - 1)) {
                pivot = i;
                break;
            }
        }
        if (pivot == 0) {
            return 0;
        }
        for (int i = pivot + 1; i < n; i++) {
            if (nums.get(i) < nums.get(i - 1)) {
                return -1;
            }
        }
        if (nums.get(n - 1) <= nums.get(0)) {
            return n - pivot;
        } else {
            return -1;
        }
    }
}