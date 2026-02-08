class Solution {
    public boolean sumGame(String num) {
        int n = num.length();
        int count = 0;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            if (num.charAt(i) == '?') {
                if (i < n / 2) {
                    count++;
                } else {
                    count--;
                }
            } else {
                if (i < n / 2) {
                    sum += num.charAt(i) - '0';
                } else {
                    sum -= num.charAt(i) - '0';
                }
            }
        }
        if (count == 0) {
            return sum != 0;
        }
        if (count % 2 != 0) {
            return true;
        }
        return sum != count / 2 * -9;
    }
}