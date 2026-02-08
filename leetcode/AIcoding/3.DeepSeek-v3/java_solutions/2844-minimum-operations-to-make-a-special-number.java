class Solution {
    public int minimumOperations(String num) {
        int n = num.length();
        int res = n;
        boolean foundZero = false;
        for (int i = n - 1; i >= 0; i--) {
            if (num.charAt(i) == '0') {
                for (int j = i - 1; j >= 0; j--) {
                    if (num.charAt(j) == '0' || num.charAt(j) == '5') {
                        res = Math.min(res, (i - j - 1) + (n - i - 1));
                        break;
                    }
                }
                foundZero = true;
            } else if (num.charAt(i) == '5') {
                for (int j = i - 1; j >= 0; j--) {
                    if (num.charAt(j) == '2' || num.charAt(j) == '7') {
                        res = Math.min(res, (i - j - 1) + (n - i - 1));
                        break;
                    }
                }
            }
        }
        if (foundZero) {
            res = Math.min(res, n - 1);
        }
        return res;
    }
}