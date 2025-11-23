class Solution {
    public int removePalindromeSub(String s) {
        if (s == null || s.length() == 0) {
            return 0;
        }
        String reversed = new StringBuilder(s).reverse().toString();
        return s.equals(reversed) ? 1 : 2;
    }
}