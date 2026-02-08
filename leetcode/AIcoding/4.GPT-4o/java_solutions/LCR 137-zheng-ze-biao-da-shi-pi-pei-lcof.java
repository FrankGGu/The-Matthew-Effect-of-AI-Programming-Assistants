class Solution {
    public boolean camelMatch(String[] queries, String pattern) {
        boolean[] result = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            result[i] = isMatch(queries[i], pattern);
        }
        return result;
    }

    private boolean isMatch(String query, String pattern) {
        int j = 0;
        for (int i = 0; i < query.length(); i++) {
            if (j < pattern.length() && query.charAt(i) == pattern.charAt(j)) {
                j++;
            } else if (Character.isUpperCase(query.charAt(i))) {
                return false;
            }
        }
        return j == pattern.length();
    }
}