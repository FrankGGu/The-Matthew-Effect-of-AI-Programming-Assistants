class Solution {
    public List<List<Integer>> findSubsequences(int[] nums) {
        List<List<Integer>> res = new ArrayList<>();
        backtrack(res, new ArrayList<>(), nums, 0);
        return res;
    }

    private void backtrack(List<List<Integer>> res, List<Integer> temp, int[] nums, int start) {
        if (temp.size() >= 2) {
            res.add(new ArrayList<>(temp));
        }
        Set<Integer> used = new HashSet<>();
        for (int i = start; i < nums.length; i++) {
            if (used.contains(nums[i])) continue;
            if (temp.size() == 0 || nums[i] >= temp.get(temp.size() - 1)) {
                used.add(nums[i]);
                temp.add(nums[i]);
                backtrack(res, temp, nums, i + 1);
                temp.remove(temp.size() - 1);
            }
        }
    }
}