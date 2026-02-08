class Solution {
    public int[] findStableMountainIndices(int[] nums) {
        List<Integer> res = new ArrayList<>();
        int n = nums.length;
        if (n < 3) return new int[0];

        for (int i = 1; i < n - 1; i++) {
            if (nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) {
                int left = i - 1;
                while (left >= 0 && nums[left] < nums[left + 1]) {
                    left--;
                }
                int right = i + 1;
                while (right < n && nums[right] < nums[right - 1]) {
                    right++;
                }
                if (left + 1 == 0 && right - 1 == n - 1) {
                    res.add(i);
                }
            }
        }

        int[] result = new int[res.size()];
        for (int i = 0; i < res.size(); i++) {
            result[i] = res.get(i);
        }
        return result;
    }
}