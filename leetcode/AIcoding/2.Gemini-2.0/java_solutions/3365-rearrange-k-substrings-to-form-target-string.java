class Solution {
    public boolean canRearrange(String s, String target, int k) {
        int[] sFreq = new int[26];
        int[] targetFreq = new int[26];
        for (char c : s.toCharArray()) {
            sFreq[c - 'a']++;
        }
        for (char c : target.toCharArray()) {
            targetFreq[c - 'a']++;
        }
        for (int i = 0; i < 26; i++) {
            if (targetFreq[i] > sFreq[i]) {
                return false;
            }
        }
        for (int i = 0; i < 26; i++) {
            if (targetFreq[i] > 0) {
                int need = targetFreq[i];
                int have = sFreq[i];
                if ((need + k - 1) / k > (have + k - 1) / k) {
                    return false;
                }
            }
        }
        return true;
    }
}