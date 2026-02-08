class Solution {
    public int[] transformArray(int[] arr) {
        int[] prev = arr.clone();
        int[] curr = arr.clone();
        boolean changed = true;

        while (changed) {
            changed = false;
            for (int i = 1; i < arr.length - 1; i++) {
                if (prev[i - 1] > prev[i] && prev[i] < prev[i + 1]) {
                    curr[i] = prev[i] + 1;
                    changed = true;
                } else if (prev[i - 1] < prev[i] && prev[i] > prev[i + 1]) {
                    curr[i] = prev[i] - 1;
                    changed = true;
                } else {
                    curr[i] = prev[i];
                }
            }
            prev = curr.clone();
        }

        return prev;
    }
}