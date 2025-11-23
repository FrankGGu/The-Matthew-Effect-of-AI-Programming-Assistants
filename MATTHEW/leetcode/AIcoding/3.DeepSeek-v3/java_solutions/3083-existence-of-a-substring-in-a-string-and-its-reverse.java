class Solution {
    public boolean isSubstringPresent(String s) {
        String reversed = new StringBuilder(s).reverse().toString();
        for (int i = 0; i < s.length() - 1; i++) {
            String substring = s.substring(i, i + 2);
            if (reversed.contains(substring)) {
                return true;
            }
        }
        return false;
    }
}