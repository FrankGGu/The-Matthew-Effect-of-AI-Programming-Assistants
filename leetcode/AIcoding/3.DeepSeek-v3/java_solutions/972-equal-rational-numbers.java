class Solution {
    public boolean isRationalEqual(String s, String t) {
        return Math.abs(parse(s) - parse(t)) < 1e-9;
    }

    private double parse(String s) {
        int idx = s.indexOf('(');
        if (idx == -1) {
            return Double.valueOf(s);
        }
        String base = s.substring(0, idx);
        String rep = s.substring(idx + 1, s.length() - 1);
        StringBuilder sb = new StringBuilder(base);
        for (int i = 0; i < 20; i++) {
            sb.append(rep);
        }
        return Double.valueOf(sb.toString());
    }
}