import java.util.Arrays;

class Solution {
    public long[] getFinalState(int n, int k, int[] type, int[] l, int[] r, int[] val) {
        long[] arr = new long[n];
        Arrays.fill(arr, 1);

        for (int i = 0; i < k; i++) {
            int left = l[i] - 1;
            int right = r[i] - 1;
            if (type[i] == 1) {
                for (int j = left; j <= right; j++) {
                    arr[j] *= val[i];
                }
            } else {
                for (int j = left; j <= right; j++) {
                    if (arr[j] % val[i] == 0) {
                        arr[j] /= val[i];
                    }
                }
            }
        }

        return arr;
    }
}