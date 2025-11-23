class Solution {
    public boolean isRationalEqual(String s, String t) {
        return eq(parse(s), parse(t));
    }

    private boolean eq(double a, double b) {
        return Math.abs(a - b) < 1e-12;
    }

    private double parse(String s) {
        int i = s.indexOf('(');
        if (i < 0) {
            return Double.parseDouble(s);
        }
        double nonRepeat = Double.parseDouble(s.substring(0, i));
        String repeat = s.substring(i + 1, s.length() - 1);
        double repeatVal = Double.parseDouble("0." + repeat);
        double factor = Math.pow(10, -repeat.length());
        return nonRepeat + repeatVal / (1 - factor);
    }
}