import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public int[] recoverArray(int n, int[] sums) {
        Arrays.sort(sums);
        List<Integer> res = new ArrayList<>();
        List<Integer> ans = new ArrayList<>();
        List<Integer> list = new ArrayList<>();
        int[] arr = new int[n];
        recover(n, sums, 0, arr, 0);
        return arr;
    }

    private boolean recover(int n, int[] sums, int index, int[] arr, int count) {
        if (count == n) {
            return true;
        }
        int diff = sums[1] - sums[0];
        List<Integer> positive = new ArrayList<>();
        List<Integer> negative = new ArrayList<>();
        int[] p = new int[sums.length / 2];
        int[] q = new int[sums.length / 2];
        int pIndex = 0;
        int qIndex = 0;
        boolean flag = false;
        int zeroCount = 0;
        for (int i = 0; i < sums.length; i++) {
            if (i > 0 && sums[i] == sums[0]) {
                zeroCount++;
            }
        }

        int k = 0;
        boolean foundDiff = false;
        for (int i = 0; i < sums.length; i++) {
            if (k < sums.length && sums[i] == sums[k]) {
                p[pIndex++] = sums[i];
                k = Arrays.binarySearch(sums, sums[i] + diff);
                q[qIndex++] = sums[k];
            } else {
                return false;
            }
        }

        arr[count] = diff;
        int[] newSums = new int[p.length];
        System.arraycopy(p, 0, newSums, 0, p.length);
        if (recover(n, newSums, index + 1, arr, count + 1)) {
            return true;
        }

        arr[count] = -diff;
        newSums = new int[p.length];
        System.arraycopy(p, 0, newSums, 0, p.length);
        for (int i = 0; i < newSums.length; i++) {
            newSums[i] = -newSums[i];
        }
        Arrays.sort(newSums);

        if (recover(n, newSums, index + 1, arr, count + 1)) {
            return true;
        }

        return false;
    }
}