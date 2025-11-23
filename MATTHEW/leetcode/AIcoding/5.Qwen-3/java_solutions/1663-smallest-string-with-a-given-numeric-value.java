public class Solution {
    public String getSmallestString(int n, int k) {
        char[] result = new char[n];
        Arrays.fill(result, 'a');
        k -= n;
        for (int i = n - 1; i >= 0 && k > 0; i--) {
            int add = Math.min(k, 25);
            result[i] += add;
            k -= add;
        }
        return new String(result);
    }
}