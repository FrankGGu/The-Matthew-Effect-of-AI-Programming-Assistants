class Solution {
    public int countSteppingNumbers(int low, int high) {
        return count(high) - count(low) + isSteppingNumber(low);
    }

    private int count(int n) {
        String s = String.valueOf(n);
        int len = s.length();
        int res = 0;

        for (int i = 1; i < len; i++) {
            res += 9 * (int) Math.pow(10, i - 1);
        }

        for (int i = 0; i < len; i++) {
            for (int j = (i == 0 ? 1 : 0); j < s.charAt(i) - '0'; j++) {
                if (i == 0) {
                    res += solve(len - 1, j);
                } else {
                    if (Math.abs(j - (s.charAt(i - 1) - '0')) == 1) {
                        res += solve(len - i - 1, j);
                    }
                }
            }

            if (i > 0 && Math.abs((s.charAt(i) - '0') - (s.charAt(i - 1) - '0')) != 1) {
                break;
            }
            if (i == len - 1) {
                res++;
            }
        }

        return res;
    }

    private int solve(int digits, int prevDigit) {
        if (digits == 0) {
            return 1;
        }

        int res = 0;
        if (prevDigit > 0) {
            res += solve(digits - 1, prevDigit - 1);
        }
        if (prevDigit < 9) {
            res += solve(digits - 1, prevDigit + 1);
        }

        return res;
    }

    private int isSteppingNumber(int n) {
        String s = String.valueOf(n);
        for (int i = 1; i < s.length(); i++) {
            if (Math.abs((s.charAt(i) - '0') - (s.charAt(i - 1) - '0')) != 1) {
                return 0;
            }
        }
        return 1;
    }
}