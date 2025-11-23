class Solution {
    public int dismantlingAction(int[] actions) {
        if (actions == null || actions.length == 0) {
            return 0;
        }
        int count = 1;
        for (int i = 1; i < actions.length; i++) {
            if (actions[i] != actions[i - 1]) {
                count++;
            }
        }
        return count;
    }
}