import java.util.Arrays;

public class Solution {
    public int minOperations(int[] target, int[] arr) {
        int n = target.length;
        int m = arr.length;
        int[] index = new int[n];
        Arrays.fill(index, -1);

        for (int i = 0; i < n; i++) {
            index[target[i]] = i;
        }

        int[] lis = new int[m];
        int size = 0;

        for (int num : arr) {
            if (index[num] != -1) {
                int pos = Arrays.binarySearch(lis, 0, size, index[num]);
                if (pos < 0) {
                    pos = -(pos + 1);
                }
                lis[pos] = index[num];
                if (pos == size) {
                    size++;
                }
            }
        }

        return n - size;
    }
}