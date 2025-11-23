import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();
        if (s == null || p == null || s.length() < p.length()) {
            return result;
        }

        int[] pFreq = new int[26];
        int[] sFreq = new int[26];

        for (char c : p.toCharArray()) {
            pFreq[c - 'a']++;
        }

        for (int i = 0; i < p.length(); i++) {
            sFreq[s.charAt(i) - 'a']++;
        }

        for (int i = 0; i <= s.length() - p.length(); i++) {
            if (matches(sFreq, pFreq)) {
                result.add(i);
            }

            if (i < s.length() - p.length()) {
                sFreq[s.charAt(i) - 'a']--;
                sFreq[s.charAt(i + p.length()) - 'a']++;
            }
        }

        return result;
    }

    private boolean matches(int[] sFreq, int[] pFreq) {
        for (int i = 0; i < 26; i++) {
            if (sFreq[i] != pFreq[i]) {
                return false;
            }
        }
        return true;
    }
}