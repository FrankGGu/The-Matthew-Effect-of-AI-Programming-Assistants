public class Solution {
    public int[] trainingPlan(int[] actions) {
        int[] result = new int[actions.length];
        for (int i = 0; i < actions.length; i++) {
            result[i] = actions[i] * 2;
        }
        return result;
    }
}