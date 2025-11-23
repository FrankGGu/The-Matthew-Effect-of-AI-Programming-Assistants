import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    int[] charToDigit = new int[26];
    boolean[] digitUsed = new boolean[10];
    char[] uniqueChars;
    boolean[] isLeading = new boolean[26];

    String[] words;
    String result;

    public boolean isSolvable(String[] words, String result) {
        this.words = words;
        this.result = result;

        Arrays.fill(charToDigit, -1);

        Set<Character> charSet = new HashSet<>();
        for (String word : words) {
            for (char c : word.toCharArray()) {
                charSet.add(c);
            }
            if (word.length() > 1) {
                isLeading[word.charAt(0) - 'A'] = true;
            }
        }
        for (char c : result.toCharArray()) {
            charSet.add(c);
        }
        if (result.length() > 1) {
            isLeading[result.charAt(0) - 'A'] = true;
        }

        uniqueChars = new char[charSet.size()];
        int i = 0;
        for (char c : charSet) {
            uniqueChars[i++] = c;
        }

        return backtrack(0);
    }

    private boolean backtrack(int k) {
        if (k == uniqueChars.length) {
            return check();
        }

        char currentChar = uniqueChars[k];
        int charIdx = currentChar - 'A';

        for (int digit = 0; digit <= 9; digit++) {
            if (isLeading[charIdx] && digit == 0) {
                continue;
            }
            if (!digitUsed[digit]) {
                charToDigit[charIdx] = digit;
                digitUsed[digit] = true;

                if (backtrack(k + 1)) {
                    return true;
                }

                digitUsed[digit] = false;
                charToDigit[charIdx] = -1;
            }
        }
        return false;
    }

    private long getWordValue(String word) {
        long value = 0;
        for (char c : word.toCharArray()) {
            value = value * 10 + charToDigit[c - 'A'];
        }
        return value;
    }

    private boolean check() {
        long sumWords = 0;
        for (String word : words) {
            sumWords += getWordValue(word);
        }
        long resultValue = getWordValue(result);

        return sumWords == resultValue;
    }
}