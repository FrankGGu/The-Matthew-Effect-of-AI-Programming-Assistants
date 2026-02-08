class Solution {
    public int reinitializePermutation(int n) {
        int[] perm = new int[n];
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            perm[i] = i;
            arr[i] = i;
        }
        int count = 0;
        while (true) {
            int[] newArr = new int[n];
            for (int i = 0; i < n; i++) {
                if (i % 2 == 0) {
                    newArr[i] = arr[i / 2];
                } else {
                    newArr[i] = arr[n / 2 + (i - 1) / 2];
                }
            }
            count++;
            boolean isEqual = true;
            for (int i = 0; i < n; i++) {
                if (newArr[i] != perm[i]) {
                    isEqual = false;
                    break;
                }
            }
            if (isEqual) {
                return count;
            }
            arr = newArr;
        }
    }
}