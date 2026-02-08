class Solution {
    public List<List<Integer>> highestScoreDivisions(int[] nums) {
        int n = nums.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + (nums[i] == 1 ? 1 : -1);
        }

        int maxScore = Integer.MIN_VALUE;
        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            int score = prefixSum[i + 1];
            if (score > maxScore) {
                maxScore = score;
                result.clear();
                result.add(Arrays.asList(i + 1));
            } else if (score == maxScore) {
                result.add(Arrays.asList(i + 1));
            }
        }

        return result;
    }
}