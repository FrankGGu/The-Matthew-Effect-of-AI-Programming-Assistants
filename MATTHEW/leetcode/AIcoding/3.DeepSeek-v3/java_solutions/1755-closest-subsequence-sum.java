class Solution {
    public int minAbsDifference(int[] nums, int goal) {
        int n = nums.length;
        List<Integer> left = new ArrayList<>();
        List<Integer> right = new ArrayList<>();

        generateSubsets(nums, 0, n / 2, 0, left);
        generateSubsets(nums, n / 2, n, 0, right);

        Collections.sort(right);

        int res = Integer.MAX_VALUE;

        for (int l : left) {
            int target = goal - l;
            int idx = Collections.binarySearch(right, target);

            if (idx >= 0) {
                return 0;
            } else {
                idx = -idx - 1;
                if (idx < right.size()) {
                    res = Math.min(res, Math.abs(l + right.get(idx) - goal));
                }
                if (idx > 0) {
                    res = Math.min(res, Math.abs(l + right.get(idx - 1) - goal));
                }
            }
        }

        return res;
    }

    private void generateSubsets(int[] nums, int start, int end, int sum, List<Integer> list) {
        if (start == end) {
            list.add(sum);
            return;
        }
        generateSubsets(nums, start + 1, end, sum + nums[start], list);
        generateSubsets(nums, start + 1, end, sum, list);
    }
}