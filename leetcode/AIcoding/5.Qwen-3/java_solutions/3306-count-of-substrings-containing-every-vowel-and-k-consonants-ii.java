public class Solution {

import java.util.*;

public class Solution {
    public int[] vowelCountAndConsonantCount(String s, int k) {
        int[] result = new int[2];
        int vowels = 0;
        int consonants = 0;
        Set<Character> vowelsSet = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));

        for (int i = 0; i < k; i++) {
            if (vowelsSet.contains(s.charAt(i))) {
                vowels++;
            } else {
                consonants++;
            }
        }

        result[0] = vowels;
        result[1] = consonants;
        return result;
    }

    public int countOfSubstringsWithVowelAndConsonantCount(String s, int k, int vowelCount, int consonantCount) {
        int count = 0;
        int n = s.length();
        Set<Character> vowelsSet = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));

        for (int i = 0; i <= n - k; i++) {
            int currentVowels = 0;
            int currentConsonants = 0;
            for (int j = i; j < i + k; j++) {
                if (vowelsSet.contains(s.charAt(j))) {
                    currentVowels++;
                } else {
                    currentConsonants++;
                }
            }
            if (currentVowels == vowelCount && currentConsonants == consonantCount) {
                count++;
            }
        }

        return count;
    }

    public int countOfSubstringsContainingEveryVowelAndKConsonantsII(String s, int k) {
        int n = s.length();
        int total = 0;
        Set<Character> vowelsSet = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));
        int[] vowelCounts = new int[5];
        int uniqueVowels = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);
            if (vowelsSet.contains(c)) {
                int index = c - 'a';
                if (vowelCounts[index] == 0) {
                    uniqueVowels++;
                }
                vowelCounts[index]++;
            }

            while (uniqueVowels == 5 && right - left + 1 >= k) {
                int currentVowelCount = 0;
                int currentConsonantCount = 0;
                for (int i = left; i <= right; i++) {
                    if (vowelsSet.contains(s.charAt(i))) {
                        currentVowelCount++;
                    } else {
                        currentConsonantCount++;
                    }
                }
                if (currentConsonantCount == k) {
                    total++;
                }

                char leftChar = s.charAt(left);
                if (vowelsSet.contains(leftChar)) {
                    int index = leftChar - 'a';
                    vowelCounts[index]--;
                    if (vowelCounts[index] == 0) {
                        uniqueVowels--;
                    }
                }
                left++;
            }
        }

        return total;
    }

    public int countOfSubstringsContainingEveryVowelAndKConsonantsII(String s, int k) {
        int n = s.length();
        int total = 0;
        Set<Character> vowelsSet = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));
        int[] vowelCounts = new int[5];
        int uniqueVowels = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);
            if (vowelsSet.contains(c)) {
                int index = c - 'a';
                if (vowelCounts[index] == 0) {
                    uniqueVowels++;
                }
                vowelCounts[index]++;
            }

            while (uniqueVowels == 5) {
                int currentConsonantCount = 0;
                for (int i = left; i <= right; i++) {
                    if (!vowelsSet.contains(s.charAt(i))) {
                        currentConsonantCount++;
                    }
                }
                if (currentConsonantCount == k) {
                    total++;
                }

                char leftChar = s.charAt(left);
                if (vowelsSet.contains(leftChar)) {
                    int index = leftChar - 'a';
                    vowelCounts[index]--;
                    if (vowelCounts[index] == 0) {
                        uniqueVowels--;
                    }
                }
                left++;
            }
        }

        return total;
    }

    public int countOfSubstringsContainingEveryVowelAndKConsonantsII(String s, int k) {
        int n = s.length();
        int total = 0;
        Set<Character> vowelsSet = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));
        int[] vowelCounts = new int[5];
        int uniqueVowels = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);
            if (vowelsSet.contains(c)) {
                int index = c - 'a';
                if (vowelCounts[index] == 0) {
                    uniqueVowels++;
                }
                vowelCounts[index]++;
            }

            while (uniqueVowels == 5) {
                int currentConsonantCount = 0;
                for (int i = left; i <= right; i++) {
                    if (!vowelsSet.contains(s.charAt(i))) {
                        currentConsonantCount++;
                    }
                }
                if (currentConsonantCount == k) {
                    total++;
                }

                char leftChar = s.charAt(left);
                if (vowelsSet.contains(leftChar)) {
                    int index = leftChar - 'a';
                    vowelCounts[index]--;
                    if (vowelCounts[index] == 0) {
                        uniqueVowels--;
                    }
                }
                left++;
            }
        }

        return total;
    }

    public int countOfSubstringsContainingEveryVowelAndKConsonantsII(String s, int k) {
        int n = s.length();
        int total = 0;
        Set<Character> vowelsSet = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));
        int[] vowelCounts = new int[5];
        int uniqueVowels = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);
            if (vowelsSet.contains(c)) {
                int index = c - 'a';
                if (vowelCounts[index] == 0) {
                    uniqueVowels++;
                }
                vowelCounts[index]++;
            }

            while (uniqueVowels == 5) {
                int currentConsonantCount = 0;
                for (int i = left; i <= right; i++) {
                    if (!vowelsSet.contains(s.charAt(i))) {
                        currentConsonantCount++;
                    }
                }
                if (currentConsonantCount == k) {
                    total++;
                }

                char leftChar = s.charAt(left);
                if (vowelsSet.contains(leftChar)) {
                    int index = leftChar - 'a';
                    vowelCounts[index]--;
                    if (vowelCounts[index] == 0) {
                        uniqueVowels--;
                    }
                }
                left++;
            }
        }

        return total;
    }

    public int countOfSubstringsContainingEveryVowelAndKConsonantsII(String s, int k) {
        int n = s.length();
        int total = 0;
        Set<Character> vowelsSet = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));
        int[] vowelCounts = new int[5];
        int uniqueVowels = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);
            if (vowelsSet.contains(c)) {
                int index = c - 'a';
                if (vowelCounts[index] == 0) {
                    uniqueVowels++;
                }
                vowelCounts[index]++;
            }

            while (uniqueVowels == 5) {
                int currentConsonantCount = 0;
                for (int i = left; i <= right; i++) {
                    if (!vowelsSet.contains(s.charAt(i))) {
                        currentConsonantCount++;
                    }
                }
                if (currentConsonantCount == k) {
                    total++;
                }

                char leftChar = s.charAt(left);
                if (vowelsSet.contains(leftChar)) {
                    int index = leftChar - 'a';
                    vowelCounts[index]--;
                    if (vowelCounts[index] == 0) {
                        uniqueVowels--;
                    }
                }
                left++;
            }
        }

        return total;
    }

    public int countOfSubstringsContainingEveryVowelAndKConsonantsII(String s, int k) {
        int n = s.length();
        int total = 0;
        Set<Character> vowelsSet =
}