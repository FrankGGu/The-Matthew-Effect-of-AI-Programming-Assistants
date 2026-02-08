import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();
        if (s == null || p == null || s.length() < p.length()) {
            return result;
        }

        int[] pFreq = new int[26];
        int[] sWindowFreq = new int[26];

        for (char c : p.toCharArray()) {
            pFreq[c - 'a']++;
        }

        for (int i = 0; i < p.length(); i++) {
            sWindowFreq[s.charAt(i) - 'a']++;
        }

        if (areArraysEqual(pFreq, sWindowFreq)) {
            result.add(0);
        }

        for (int i = p.length(); i < s.length(); i++) {
            sWindowFreq[s.charAt(i - p.length()) - 'a']--;
            sWindowFreq[s.charAt(i) - 'a']++;

            if (areArraysEqual(pFreq, sWindowFreq)) {
                result.add(i - p.length() + 1);
            }
        }

        return result;
    }

    private boolean areArraysEqual(int[] arr1, int[] arr2) {
        for (int i = 0; i < 26; i++) {
            if (arr1[i] != arr2[i]) {
                return false;
            }
        }
        return true;
    }
}