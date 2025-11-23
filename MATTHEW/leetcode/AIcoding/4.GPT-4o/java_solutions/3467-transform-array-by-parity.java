class Solution {
    public int[] transformArray(int[] arr) {
        int n = arr.length;
        int[] result = arr.clone();
        boolean changed;
        do {
            changed = false;
            for (int i = 1; i < n - 1; i++) {
                if (arr[i] % 2 == 0 && arr[i - 1] > arr[i] && arr[i + 1] > arr[i]) {
                    result[i] = arr[i] + 1;
                    changed = true;
                } else if (arr[i] % 2 == 1 && arr[i - 1] < arr[i] && arr[i + 1] < arr[i]) {
                    result[i] = arr[i] - 1;
                    changed = true;
                }
            }
            arr = result.clone();
        } while (changed);
        return result;
    }
}