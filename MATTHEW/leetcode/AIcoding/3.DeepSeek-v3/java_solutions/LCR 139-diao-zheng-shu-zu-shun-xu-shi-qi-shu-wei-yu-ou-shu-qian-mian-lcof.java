class Solution {
    public int[] trainingPlan(int[] actions) {
        int left = 0;
        int right = actions.length - 1;
        while (left < right) {
            while (left < right && actions[left] % 2 == 1) {
                left++;
            }
            while (left < right && actions[right] % 2 == 0) {
                right--;
            }
            if (left < right) {
                int temp = actions[left];
                actions[left] = actions[right];
                actions[right] = temp;
                left++;
                right--;
            }
        }
        return actions;
    }
}