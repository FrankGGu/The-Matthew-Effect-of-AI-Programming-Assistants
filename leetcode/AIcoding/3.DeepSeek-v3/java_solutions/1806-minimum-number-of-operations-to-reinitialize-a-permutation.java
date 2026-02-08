class Solution {
    public int reinitializePermutation(int n) {
        int[] perm = new int[n];
        for (int i = 0; i < n; i++) {
            perm[i] = i;
        }
        int[] original = perm.clone();
        int[] arr = new int[n];
        int operations = 0;
        while (true) {
            operations++;
            for (int i = 0; i < n; i++) {
                if (i % 2 == 0) {
                    arr[i] = perm[i / 2];
                } else {
                    arr[i] = perm[n / 2 + (i - 1) / 2];
                }
            }
            if (Arrays.equals(arr, original)) {
                break;
            }
            perm = arr.clone();
        }
        return operations;
    }
}