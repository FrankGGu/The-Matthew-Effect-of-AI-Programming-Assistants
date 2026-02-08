class Solution {
    private int count = 0;

    public int numSquarefulPerms(int[] nums) {
        Arrays.sort(nums);
        boolean[] used = new boolean[nums.length];
        backtrack(nums, used, new ArrayList<>());
        return count;
    }

    private void backtrack(int[] nums, boolean[] used, List<Integer> path) {
        if (path.size() == nums.length) {
            count++;
            return;
        }

        for (int i = 0; i < nums.length; i++) {
            if (used[i] || (i > 0 && nums[i] == nums[i - 1] && !used[i - 1])) {
                continue;
            }

            if (!path.isEmpty()) {
                int sum = path.get(path.size() - 1) + nums[i];
                int sqrt = (int) Math.sqrt(sum);
                if (sqrt * sqrt != sum) {
                    continue;
                }
            }

            used[i] = true;
            path.add(nums[i]);
            backtrack(nums, used, path);
            path.remove(path.size() - 1);
            used[i] = false;
        }
    }
}