class Solution {
    public int kBeauty(String num, int k) {
        int n = num.length();
        if (k > n) return 0;

        int count = 0;
        for (int i = 0; i <= n - k; i++) {
            String substring = num.substring(i, i + k);
            if (!substring.equals("0") && Integer.parseInt(substring) % k == 0) {
                count++;
            }
        }
        return count;
    }
}