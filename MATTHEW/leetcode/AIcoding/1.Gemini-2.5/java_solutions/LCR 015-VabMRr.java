import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();

        int sLen = s.length();
        int pLen = p.length();

        if (pLen > sLen) {
            return result;
        }

        int[] pFreq = new int[26];
        int[] sFreq = new int[26];

        for (char c : p.toCharArray()) {
            pFreq[c - 'a']++;
        }

        for (int i = 0; i < pLen; i++) {
            sFreq[s.charAt(i) - 'a']++;
        }

        if (Arrays.equals(pFreq, sFreq)) {
            result.add(0);
        }

        for (int i = pLen; i < sLen; i++) {
            sFreq[s.charAt(i) - 'a']++;
            sFreq[s.charAt(i - pLen) - 'a']--;

            if (Arrays.equals(pFreq, sFreq)) {
                result.add(i - pLen + 1);
            }
        }

        return result;
    }
}