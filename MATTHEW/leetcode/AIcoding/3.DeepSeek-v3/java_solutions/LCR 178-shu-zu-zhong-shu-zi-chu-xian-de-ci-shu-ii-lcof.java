class Solution {
    public int trainingPlan(int[] actions) {
        int ones = 0, twos = 0;
        for (int action : actions) {
            ones = (ones ^ action) & ~twos;
            twos = (twos ^ action) & ~ones;
        }
        return ones;
    }
}