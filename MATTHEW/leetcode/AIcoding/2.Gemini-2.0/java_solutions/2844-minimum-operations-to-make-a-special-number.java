class Solution {
    public int minimumOperations(String num) {
        int n = num.length();
        int ans = n;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int val = (num.charAt(i) - '0') * 10 + (num.charAt(j) - '0');
                if (val % 25 == 0) {
                    ans = Math.min(ans, n - i - 2);
                }
            }
        }
        for (int i = 0; i < n; i++) {
            if (num.charAt(i) == '0') {
                ans = Math.min(ans, n - 1);
            }
        }
        return ans;
    }
}