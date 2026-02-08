import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {

    private void computeLPSArray(String pattern, int[] lps) {
        int length = 0;
        int i = 1;
        lps[0] = 0;

        while (i < pattern.length()) {
            if (pattern.charAt(i) == pattern.charAt(length)) {
                length++;
                lps[i] = length;
                i++;
            } else {
                if (length != 0) {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
    }

    private void kmpSearch(String text, String pattern, List<Integer> occurrences) {
        int N = text.length();
        int M = pattern.length();

        if (M == 0) {
            for (int i = 0; i <= N; i++) {
                occurrences.add(i);
            }
            return;
        }
        if (N == 0 || M > N) {
            return;
        }

        int[] lps = new int[M];
        computeLPSArray(pattern, lps);

        int i = 0;
        int j = 0;
        while (i < N) {
            if (pattern.charAt(j) == text.charAt(i)) {
                i++;
                j++;
            }

            if (j == M) {
                occurrences.add(i - j);
                j = lps[j - 1];
            } else if (i < N && pattern.charAt(j) != text.charAt(i)) {
                if (j != 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
    }

    public List<Integer> beautifulIndices(String s, String a, String b, int k) {
        List<Integer> aOccurrences = new ArrayList<>();
        List<Integer> bOccurrences = new ArrayList<>();

        kmpSearch(s, a, aOccurrences);
        kmpSearch(s, b, bOccurrences);

        List<Integer> result = new ArrayList<>();

        if (aOccurrences.isEmpty() || bOccurrences.isEmpty()) {
            return result;
        }

        for (int i : aOccurrences) {
            int lowIndex = Collections.binarySearch(bOccurrences, i - k);
            if (lowIndex < 0) {
                lowIndex = -lowIndex - 1;
            }

            boolean found = false;
            if (lowIndex < bOccurrences.size()) {
                if (bOccurrences.get(lowIndex) <= i + k) {
                    found = true;
                }
            }

            if (found) {
                result.add(i);
            }
        }

        return result;
    }
}