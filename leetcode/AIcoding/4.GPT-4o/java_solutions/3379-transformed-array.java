class Solution {
    public int[] transformArray(int[] arr) {
        int n = arr.length;
        int[] transformed = new int[n];
        boolean changed = true;

        while (changed) {
            changed = false;
            System.arraycopy(arr, 0, transformed, 0, n);
            for (int i = 1; i < n - 1; i++) {
                if (arr[i] < arr[i - 1] && arr[i] < arr[i + 1]) {
                    transformed[i] = arr[i] + 1;
                    changed = true;
                } else if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
                    transformed[i] = arr[i] - 1;
                    changed = true;
                }
            }
            int[] temp = arr;
            arr = transformed;
            transformed = temp;
        }

        return arr;
    }
}