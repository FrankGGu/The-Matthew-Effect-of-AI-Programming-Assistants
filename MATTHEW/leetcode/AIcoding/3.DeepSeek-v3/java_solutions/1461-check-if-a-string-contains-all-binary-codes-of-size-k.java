class Solution {
    public boolean hasAllCodes(String s, int k) {
        int need = 1 << k;
        Set<String> seen = new HashSet<>();
        for (int i = k; i <= s.length(); i++) {
            String sub = s.substring(i - k, i);
            if (!seen.contains(sub)) {
                seen.add(sub);
                need--;
                if (need == 0) {
                    return true;
                }
            }
        }
        return false;
    }
}