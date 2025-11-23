class Solution {
    public String getSmallestString(int n, int k) {
        char[] result = new char[n];
        Arrays.fill(result, 'a');
        k -= n;
        int i = n - 1;
        while (k > 0) {
            int add = Math.min(k, 25);
            result[i] += add;
            k -= add;
            i--;
        }
        return new String(result);
    }
}