class Solution {
    public boolean hasAllCodes(String s, int k) {
        int totalCodes = 1 << k;
        Set<String> seen = new HashSet<>();

        for (int i = 0; i <= s.length() - k; i++) {
            seen.add(s.substring(i, i + k));
            if (seen.size() == totalCodes) {
                return true;
            }
        }

        return false;
    }
}