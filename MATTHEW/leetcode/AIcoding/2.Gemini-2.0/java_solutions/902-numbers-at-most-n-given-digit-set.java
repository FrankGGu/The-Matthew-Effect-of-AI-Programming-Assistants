class Solution {
    public int atMostNGivenDigitSet(String[] digits, int n) {
        String s = String.valueOf(n);
        int k = s.length();
        int ans = 0;
        int m = digits.length;
        for (int i = 1; i < k; ++i) {
            ans += Math.pow(m, i);
        }

        for (int i = 0; i < k; ++i) {
            boolean hasSameNum = false;
            for (String d : digits) {
                if (d.charAt(0) < s.charAt(i)) {
                    ans += Math.pow(m, k - i - 1);
                } else if (d.charAt(0) == s.charAt(i)) {
                    hasSameNum = true;
                }
            }
            if (!hasSameNum) {
                return ans;
            }
            if (i == k - 1) {
                ans++;
            }
        }

        return ans;
    }
}