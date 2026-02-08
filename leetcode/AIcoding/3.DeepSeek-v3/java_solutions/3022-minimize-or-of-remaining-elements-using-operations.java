class Solution {
    public int minimizeOr(int[] nums) {
        int res = 0;
        for (int i = 31; i >= 0; i--) {
            int mask = 1 << i;
            int temp = res | mask;
            int cnt = 0;
            for (int num : nums) {
                if ((num & temp) == temp) {
                    cnt++;
                }
            }
            if (cnt >= 2) {
                res = temp;
            }
        }
        return res;
    }
}