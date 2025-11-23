import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> beautifulIndices(String s, String a, String b, int k) {
        List<Integer> occurrencesA = kmpSearch(s, a);
        List<Integer> occurrencesB = kmpSearch(s, b);

        List<Integer> result = new ArrayList<>();

        if (occurrencesA.isEmpty() || occurrencesB.isEmpty()) {
            return result;
        }

        int ptrB = 0; 

        for (int idxA : occurrencesA) {
            while (ptrB < occurrencesB.size() && occurrencesB.get(ptrB) < idxA - k) {
                ptrB++;
            }

            int currentPtrB = ptrB;
            while (currentPtrB < occurrencesB.size() && occurrencesB.get(currentPtrB) <= idxA + k) {
                result.add(idxA);
                break; 
            }
        }

        return result;
    }

    private List<Integer> kmpSearch(String text, String pattern) {
        List<Integer> occurrences = new ArrayList<>();
        if (pattern.isEmpty()) {
            return occurrences; 
        }
        if (text.isEmpty() || pattern.length() > text.length()) {
            return occurrences;
        }

        int[] lps = computeLPS(pattern);
        int i = 0; 
        int j = 0; 

        while (i < text.length()) {
            if (pattern.charAt(j) == text.charAt(i)) {
                i++;
                j++;
            }
            if (j == pattern.length()) {
                occurrences.add(i - j);
                j = lps[j - 1]; 
            } else if (i < text.length() && pattern.charAt(j) != text.charAt(i)) {
                if (j != 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
        return occurrences;
    }

    private int[] computeLPS(String pattern) {
        int length = pattern.length();
        int[] lps = new int[length];
        int len = 0; 
        int i = 1;
        lps[0] = 0; 

        while (i < length) {
            if (pattern.charAt(i) == pattern.charAt(len)) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }
}