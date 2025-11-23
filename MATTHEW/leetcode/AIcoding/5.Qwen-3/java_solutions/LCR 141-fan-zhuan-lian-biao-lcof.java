public class Solution {
    public int[] trainingPlan(int[] actions, int need) {
        int[] result = new int[need];
        for (int i = 0; i < need; i++) {
            result[i] = actions[i];
        }
        return result;
    }
}