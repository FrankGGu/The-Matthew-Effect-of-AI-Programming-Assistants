class Solution {
    public int minimumLength(String s) {
        while (s.length() > 0) {
            int n = s.length();
            s = s.replaceAll("^(.)\\1*|(.)\\2*$", "");
            if (s.length() == n) break;
        }
        return s.length();
    }
}