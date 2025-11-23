class Solution {
    public int minMoves(int[] nums, int k) {
        List<Integer> ones = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                ones.add(i);
            }
        }
        int n = ones.size();
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + ones.get(i);
        }
        int res = Integer.MAX_VALUE;
        for (int i = 0; i + k <= n; i++) {
            int left = i;
            int right = i + k - 1;
            int mid = (left + right) / 2;
            int radius = mid - left;
            long leftSum = (long) (mid - left) * ones.get(mid) - (prefix[mid] - prefix[left]);
            long rightSum = (prefix[right + 1] - prefix[mid + 1]) - (long) (right - mid) * ones.get(mid);
            long total = leftSum + rightSum;
            res = (int) Math.min(res, total);
        }
        return res;
    }
}