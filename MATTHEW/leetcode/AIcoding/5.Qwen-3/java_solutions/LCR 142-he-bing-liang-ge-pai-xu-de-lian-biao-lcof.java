public class Solution {
    public int[] trainingPlan(int[] actions, int x, int y) {
        int[] result = new int[x + y];
        int i = 0;
        int j = 0;
        int k = 0;
        while (i < x && j < y) {
            if (actions[i] < actions[x + j]) {
                result[k++] = actions[i++];
            } else {
                result[k++] = actions[x + j++];
            }
        }
        while (i < x) {
            result[k++] = actions[i++];
        }
        while (j < y) {
            result[k++] = actions[x + j++];
        }
        return result;
    }
}