class Solution {
    public int countDistinct(int[] nums, int k, int p) {
        Set<String> seen = new HashSet<>();
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            int cnt = 0;
            StringBuilder sb = new StringBuilder();
            for (int j = i; j < n; j++) {
                if (nums[j] % p == 0) {
                    cnt++;
                }
                if (cnt > k) {
                    break;
                }
                sb.append(nums[j]).append(",");
                seen.add(sb.toString());
            }
        }
        return seen.size();
    }
}