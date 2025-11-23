class Solution {
    public int separateNumbers(String s) {
        int n = s.length();
        for (int len = 1; len <= n / 2; len++) {
            String firstNum = s.substring(0, len);
            long num = Long.parseLong(firstNum);
            StringBuilder sb = new StringBuilder(firstNum);
            while (sb.length() < n) {
                sb.append(++num);
            }
            if (sb.toString().equals(s)) {
                return 1;
            }
        }
        return 0;
    }
}