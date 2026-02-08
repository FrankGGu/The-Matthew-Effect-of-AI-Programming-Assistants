class Solution {
    public int distinctEchoSubstrings(String text) {
        int n = text.length();
        Set<String> set = new HashSet<>();
        for (int len = 1; len <= n / 2; len++) {
            for (int i = 0; i + 2 * len <= n; i++) {
                String a = text.substring(i, i + len);
                String b = text.substring(i + len, i + 2 * len);
                if (a.equals(b)) {
                    set.add(a);
                }
            }
        }
        return set.size();
    }
}