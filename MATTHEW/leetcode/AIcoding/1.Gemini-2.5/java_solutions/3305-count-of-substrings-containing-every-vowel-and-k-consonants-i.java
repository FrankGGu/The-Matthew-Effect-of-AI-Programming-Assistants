import java.util.HashSet;
import java.util.Set;

class Solution {

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    private int getVowelIndex(char c) {
        if (c == 'a') return 0;
        if (c == 'e') return 1;
        if (c == 'i') return 2;
        if (c == 'o') return 3;
        if (c == 'u') return 4;
        return -1; 
    }

    private long countSubstringsWithAtMostKConsonantsAndAtLeastMinVowels(String s, int maxConsonants, int minVowels) {
        int n = s.length();
        long totalCount = 0;

        int left = 0; 
        int[] vowelCounts = new int[5]; 
        int consonantCount = 0; 
        int distinctVowels = 0; 

        int leftVowelTight = 0; 
        int[] vowelCountsTight = new int[5]; 
        int distinctVowelsTight = 0; 

        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);

            if (isVowel(c)) {
                int idx = getVowelIndex(c);
                vowelCounts[idx]++;
                if (vowelCounts[idx] == 1) {
                    distinctVowels++;
                }
            } else {
                consonantCount++;
            }

            if (isVowel(c)) {
                int idx = getVowelIndex(c);
                vowelCountsTight[idx]++;
                if (vowelCountsTight[idx] == 1) {
                    distinctVowelsTight++;
                }
            }

            while (consonantCount > maxConsonants) {
                char lc = s.charAt(left);
                if (isVowel(lc)) {
                    int idx = getVowelIndex(lc);
                    vowelCounts[idx]--;
                    if (vowelCounts[idx] == 0) {
                        distinctVowels--;
                    }
                } else {
                    consonantCount--;
                }
                left++;
            }

            while (leftVowelTight < left) {
                char lvtc = s.charAt(leftVowelTight);
                if (isVowel(lvtc)) {
                    int idx = getVowelIndex(lvtc);
                    vowelCountsTight[idx]--;
                    if (vowelCountsTight[idx] == 0) {
                        distinctVowelsTight--;
                    }
                }
                leftVowelTight++;
            }

            while (distinctVowelsTight == minVowels) {
                char lvtc = s.charAt(leftVowelTight);
                if (isVowel(lvtc)) {
                    int idx = getVowelIndex(lvtc);
                    vowelCountsTight[idx]--;
                    if (vowelCountsTight[idx] == 0) {
                        distinctVowelsTight--;
                    }
                }
                leftVowelTight++;
            }

            totalCount += Math.max(0, leftVowelTight - left);
        }

        return totalCount;
    }

    public long countVowelConsonantSubstrings(String s, int k) {
        long countAtMostK = countSubstringsWithAtMostKConsonantsAndAtLeastMinVowels(s, k, 5);
        long countAtMostKMinus1 = countSubstringsWithAtMostKConsonantsAndAtLeastMinVowels(s, k - 1, 5);

        return countAtMostK - countAtMostKMinus1;
    }
}