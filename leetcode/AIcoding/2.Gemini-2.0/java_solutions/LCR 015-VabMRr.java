import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();
        if (s == null || p == null || s.length() < p.length()) {
            return result;
        }

        int[] pFreq = new int[26];
        for (char c : p.toCharArray()) {
            pFreq[c - 'a']++;
        }

        int[] sFreq = new int[26];
        for (int i = 0; i < p.length(); i++) {
            sFreq[s.charAt(i) - 'a']++;
        }

        if (Arrays.equals(sFreq, pFreq)) {
            result.add(0);
        }

        for (int i = p.length(); i < s.length(); i++) {
            sFreq[s.charAt(i - p.length()) - 'a']--;
            sFreq[s.charAt(i) - 'a']++;
            if (Arrays.equals(sFreq, pFreq)) {
                result.add(i - p.length() + 1);
            }
        }

        return result;
    }
}