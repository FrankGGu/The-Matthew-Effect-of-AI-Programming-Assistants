import java.util.Arrays;

class Solution {
    private static final int MOD = 1000000007;

    public int countSubstrings(String s, String t) {
        int n = s.length();
        int m = t.length();
        long ans = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = s.substring(i, j + 1);
                if (canRearrange(sub, t)) {
                    ans = (ans + 1) % MOD;
                }
            }
        }

        return (int) ans;
    }

    private boolean canRearrange(String s, String t) {
        int[] sFreq = new int[26];
        int[] tFreq = new int[26];

        for (char c : s.toCharArray()) {
            sFreq[c - 'a']++;
        }

        for (char c : t.toCharArray()) {
            tFreq[c - 'a']++;
        }

        int count = 0;
        for (int i = 0; i < 26; i++) {
            if (tFreq[i] > 0) {
                if (sFreq[i] >= tFreq[i]) {
                    count++;
                }
            }
        }

        if (count == 0) return false;

        int[] need = new int[26];
        for(int i = 0; i < 26; ++i){
            need[i] = tFreq[i];
        }

        int len = s.length();
        int tLen = t.length();

        if(len < tLen) return false;

        int[] have = new int[26];
        for(int i = 0; i < 26; ++i){
            have[i] = sFreq[i];
        }

        for(int i = 0; i < 26; ++i){
            if(need[i] > have[i]) return false;
        }

        return true;
    }
}