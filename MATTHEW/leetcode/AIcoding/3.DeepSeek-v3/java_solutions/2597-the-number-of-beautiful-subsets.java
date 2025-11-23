class Solution {
    public int beautifulSubsets(int[] nums, int k) {
        Arrays.sort(nums);
        int[] count = new int[1];
        backtrack(nums, k, 0, new ArrayList<>(), count);
        return count[0];
    }

    private void backtrack(int[] nums, int k, int start, List<Integer> current, int[] count) {
        if (start == nums.length) {
            if (!current.isEmpty()) {
                count[0]++;
            }
            return;
        }

        // Option 1: Do not include nums[start]
        backtrack(nums, k, start + 1, current, count);

        // Option 2: Include nums[start] if it forms a beautiful subset
        boolean canInclude = true;
        for (int num : current) {
            if (Math.abs(num - nums[start]) == k) {
                canInclude = false;
                break;
            }
        }
        if (canInclude) {
            current.add(nums[start]);
            backtrack(nums, k, start + 1, current, count);
            current.remove(current.size() - 1);
        }
    }
}