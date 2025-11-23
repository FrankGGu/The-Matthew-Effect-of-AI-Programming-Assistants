import java.util.Arrays;

class Solution {
    public int colorful(int[] a) {
        Arrays.sort(a);
        int n = a.length;
        int ans = 0;
        for (int i = 0; i < n - 1; i++) {
            if (a[i] + 1 == a[i + 1]) {
                ans++;
            }
        }
        return ans;
    }
}