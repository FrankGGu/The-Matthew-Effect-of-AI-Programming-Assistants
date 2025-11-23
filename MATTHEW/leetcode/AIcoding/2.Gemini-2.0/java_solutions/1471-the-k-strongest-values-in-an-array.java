import java.util.Arrays;

class Solution {
    public int[] getStrongest(int[] arr, int k) {
        Arrays.sort(arr);
        int n = arr.length;
        int median = arr[(n - 1) / 2];
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (a, b) -> {
            int diffA = Math.abs(arr[a] - median);
            int diffB = Math.abs(arr[b] - median);
            if (diffA != diffB) {
                return diffB - diffA;
            } else {
                return arr[b] - arr[a];
            }
        });

        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = arr[indices[i]];
        }
        return result;
    }
}