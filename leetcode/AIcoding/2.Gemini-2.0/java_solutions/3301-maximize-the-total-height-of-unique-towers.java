import java.util.Arrays;

class Solution {
    public int maxHeight(int[] A, int K) {
        Arrays.sort(A);
        int n = A.length;
        int sum = 0;
        for (int x : A) {
            sum += x;
        }
        int l = 0, r = n - 1;
        while (l < r && K > 0) {
            if (A[l] < A[r] && A[l] * 1L * (r - l) - (prefixSum(A, l, r - 1) - A[l] * 1L * (r - l)) <= K) {
                K -= (A[l] * 1L * (r - l) - (prefixSum(A, l, r - 1) - A[l] * 1L * (r - l)));
                A[l] = A[r];
                l++;
            } else if (A[l] < A[r] && A[l] * 1L * (r - l) - (prefixSum(A, l, r - 1) - A[l] * 1L * (r - l)) > K){
                A[l] += K / (r - l);
                K = 0;
            }
            else if (A[l] >= A[r] && (A[r] * 1L * (r - l) - (suffixSum(A, l + 1, r) - A[r] * 1L * (r - l))) <= K) {
                 K -= (A[r] * 1L * (r - l) - (suffixSum(A, l + 1, r) - A[r] * 1L * (r - l)));
                A[r] = A[l];
                r--;
            } else if (A[l] >= A[r] && (A[r] * 1L * (r - l) - (suffixSum(A, l + 1, r) - A[r] * 1L * (r - l))) > K) {
                A[r] += K / (r - l);
                K = 0;

            }
        }
        return A[n - 1];
    }

    private long prefixSum(int[] arr, int l, int r) {
        long sum = 0;
        for (int i = l; i <= r; i++) {
            sum += arr[i];
        }
        return sum;
    }

    private long suffixSum(int[] arr, int l, int r) {
        long sum = 0;
        for (int i = l; i <= r; i++) {
            sum += arr[i];
        }
        return sum;
    }
}