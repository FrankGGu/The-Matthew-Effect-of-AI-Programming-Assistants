public class Solution {

import java.util.*;

public class Solution {
    public int minimizeCharacters(String a, String b) {
        int[] countA = new int[26];
        int[] countB = new int[26];

        for (char c : a.toCharArray()) {
            countA[c - 'a']++;
        }

        for (char c : b.toCharArray()) {
            countB[c - 'a']++;
        }

        int res = Integer.MAX_VALUE;

        // Condition 1: All characters in a are less than all characters in b
        for (int i = 1; i < 26; i++) {
            int sumA = 0;
            int sumB = 0;
            for (int j = 0; j < i; j++) {
                sumA += countA[j];
            }
            for (int j = i; j < 26; j++) {
                sumB += countB[j];
            }
            res = Math.min(res, sumA + sumB);
        }

        // Condition 2: All characters in b are less than all characters in a
        for (int i = 1; i < 26; i++) {
            int sumA = 0;
            int sumB = 0;
            for (int j = 0; j < i; j++) {
                sumB += countB[j];
            }
            for (int j = i; j < 26; j++) {
                sumA += countA[j];
            }
            res = Math.min(res, sumA + sumB);
        }

        // Condition 3: At least one character is common between a and b
        int common = 0;
        for (int i = 0; i < 26; i++) {
            common += Math.min(countA[i], countB[i]);
        }
        res = Math.min(res, (a.length() - common) + (b.length() - common));

        return res;
    }
}
}