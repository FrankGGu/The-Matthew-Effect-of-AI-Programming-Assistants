class Solution {
    public int breakfastNumber(int[] staple, int[] drinks, int x) {
        Arrays.sort(staple);
        Arrays.sort(drinks);
        int mod = 1000000007;
        int res = 0;
        int m = staple.length, n = drinks.length;
        int i = 0, j = n - 1;
        while (i < m && j >= 0) {
            if (staple[i] + drinks[j] <= x) {
                res = (res + j + 1) % mod;
                i++;
            } else {
                j--;
            }
        }
        return res;
    }
}