class Solution {
    public int trainingPlan(int[] actions, int k) {
        int n = actions.length;
        int slow = 0, fast = 0;

        while (fast < n) {
            if (actions[fast] == 1) {
                k--;
            }

            while (k < 0) {
                if (actions[slow] == 1) {
                    k++;
                }
                slow++;
            }
            fast++;
        }

        return fast - slow;
    }
}