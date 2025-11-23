public class Solution {
    public int[] trainingPlan(int[] actions) {
        int[] result = new int[actions.length];
        int left = 0;
        int right = actions.length - 1;
        int index = 0;

        while (left <= right) {
            if (index % 2 == 0) {
                result[index++] = actions[left++];
            } else {
                result[index++] = actions[right--];
            }
        }

        return result;
    }
}