class Solution {
    public long numberOfWays(String s) {
        long total0 = 0, total1 = 0;
        for (char c : s.toCharArray()) {
            if (c == '0') total0++;
            else total1++;
        }

        long current0 = 0, current1 = 0;
        long res = 0;
        for (char c : s.toCharArray()) {
            if (c == '0') {
                res += current1 * (total1 - current1);
                current0++;
            } else {
                res += current0 * (total0 - current0);
                current1++;
            }
        }
        return res;
    }
}