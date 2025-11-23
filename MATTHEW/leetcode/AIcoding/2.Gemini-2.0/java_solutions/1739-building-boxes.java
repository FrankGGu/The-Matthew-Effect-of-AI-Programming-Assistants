class Solution {
    public int minimumBoxes(int n) {
        int k = 0;
        while (k * (k + 1) * (k + 2) / 6 <= n) {
            k++;
        }
        k--;
        n -= k * (k + 1) * (k + 2) / 6;
        int res = k * (k + 1) / 2;
        int l = 0;
        while (l * (l + 1) / 2 < n) {
            l++;
        }
        res += l;
        return res;
    }
}