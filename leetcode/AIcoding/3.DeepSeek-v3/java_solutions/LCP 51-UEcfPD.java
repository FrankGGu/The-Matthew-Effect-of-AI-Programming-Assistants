class Solution {
    private int maxSatisfaction = 0;

    public int maxSatisfaction(int[] satisfaction) {
        Arrays.sort(satisfaction);
        backtrack(satisfaction, 0, 0, 0);
        return maxSatisfaction;
    }

    private void backtrack(int[] satisfaction, int index, int total, int sum) {
        if (index == satisfaction.length) {
            if (total > maxSatisfaction) {
                maxSatisfaction = total;
            }
            return;
        }
        backtrack(satisfaction, index + 1, total + sum + satisfaction[index], sum + satisfaction[index]);
        backtrack(satisfaction, index + 1, total, sum);
    }
}