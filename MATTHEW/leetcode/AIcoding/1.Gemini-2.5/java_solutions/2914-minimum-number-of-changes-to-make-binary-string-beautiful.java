class Solution {
    public int minChanges(String s, int k) {
        int n = s.length();
        int effectiveLength = n - (n % k);
        int changes = 0;

        for (int i = 0; i < effectiveLength; i += k) {
            int onesCount = 0;
            for (int j = 0; j < k; ++j) {
                if (s.charAt(i + j) == '1') {
                    onesCount++;
                }
            }
            if (onesCount == 0) {
                changes++;
            } else if (onesCount > 1) {
                changes += (onesCount - 1);
            }
        }
        return changes;
    }
}