class Solution {
    public long countPowerfulIntegers(long start, long finish, int power, int powerStart) {
        String s = String.valueOf(start);
        String f = String.valueOf(finish);
        String ps = String.valueOf(powerStart);
        int n = f.length(), m = ps.length();
        if (n < m || !f.substring(n - m).equals(ps)) {
            return 0;
        }
        if (s.length() < m || !s.substring(s.length() - m).equals(ps)) {
            start = (long)Math.pow(10, m - 1) * (long)power;
            start = Math.max(start, (long)Math.pow(10, n - m - 1) * (long)Math.pow(10, m) + powerStart);
        }
        if (start > finish) return 0;
        long startPrefix = Long.parseLong(String.valueOf(start).substring(0, String.valueOf(start).length() - m));
        long finishPrefix = Long.parseLong(String.valueOf(finish).substring(0, String.valueOf(finish).length() - m));
        return finishPrefix - startPrefix + 1;
    }
}