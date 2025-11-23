class Solution {
    public int trainingPlan(int[] actions, int k) {
        int n = actions.length;
        int[] count = new int[2];
        for (int i = 0; i < n; i++) {
            count[actions[i]]++;
        }
        int[] arr = new int[n];
        int idx = 0;
        for (int i = 0; i < count[0]; i++) {
            arr[idx++] = 0;
        }
        for (int i = 0; i < count[1]; i++) {
            arr[idx++] = 1;
        }
        return arr[k % n];
    }
}