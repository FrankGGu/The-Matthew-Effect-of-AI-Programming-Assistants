class Solution {
    public int minNumberOperations(int[] target) {
        int n = target.length;
        if (n == 0) {
            return 0;
        }

        int operations = 0;
        int prevHeight = 0; 

        for (int i = 0; i < n; i++) {
            if (target[i] > prevHeight) {
                operations += (target[i] - prevHeight);
            }
            prevHeight = target[i];
        }

        return operations;
    }
}