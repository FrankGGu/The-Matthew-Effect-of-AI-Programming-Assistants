import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public long makeSubKSumEqual(int[] arr, int k) {
        int n = arr.length;
        k = gcd(n, k);
        long ans = 0;
        for (int i = 0; i < k; i++) {
            List<Integer> subarray = new ArrayList<>();
            for (int j = i; j < n; j += k) {
                subarray.add(arr[j]);
            }
            Collections.sort(subarray);
            int median = subarray.get(subarray.size() / 2);
            for (int num : subarray) {
                ans += Math.abs(num - median);
            }
        }
        return ans;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}