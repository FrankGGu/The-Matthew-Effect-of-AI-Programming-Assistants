public class Solution {

import java.util.*;

public class Solution {
    public boolean isSolvable(String[] words, char result) {
        Set<Character> uniqueChars = new HashSet<>();
        for (String word : words) {
            for (char c : word.toCharArray()) {
                uniqueChars.add(c);
            }
        }
        for (char c : result) {
            uniqueChars.add(c);
        }

        List<Character> chars = new ArrayList<>(uniqueChars);
        int[] mapping = new int[26];
        Arrays.fill(mapping, -1);
        boolean[] used = new boolean[26];

        return backtrack(words, result, 0, 0, 0, chars, mapping, used, new HashMap<>());
    }

    private boolean backtrack(String[] words, char result, int index, int col, int carry, List<Character> chars, int[] mapping, boolean[] used, Map<Character, Integer> charToIndex) {
        if (index == chars.size()) {
            return checkSolution(words, result, mapping);
        }

        char c = chars.get(index);
        charToIndex.put(c, index);

        int maxDigit = 9;
        if (isLeadingChar(words, result, c)) {
            maxDigit = 9;
        } else {
            maxDigit = 9;
        }

        for (int d = 0; d <= maxDigit; d++) {
            if (used[d]) continue;

            int total = carry;
            for (String word : words) {
                if (word.length() > col) {
                    char ch = word.charAt(word.length() - 1 - col);
                    if (charToIndex.containsKey(ch)) {
                        total += mapping[charToIndex.get(ch)];
                    }
                }
            }

            if (result.length() > col) {
                char ch = result.charAt(result.length() - 1 - col);
                if (charToIndex.containsKey(ch)) {
                    total += mapping[charToIndex.get(ch)];
                }
            }

            int digit = total % 10;
            if (d != digit) continue;

            mapping[charToIndex.get(c)] = d;
            used[d] = true;

            boolean next = false;
            if (col + 1 < maxLength(words, result)) {
                next = backtrack(words, result, index + 1, col + 1, total / 10, chars, mapping, used, charToIndex);
            } else {
                next = (total / 10) == 0;
            }

            if (next) return true;

            mapping[charToIndex.get(c)] = -1;
            used[d] = false;
        }

        return false;
    }

    private boolean isLeadingChar(String[] words, char result, char c) {
        for (String word : words) {
            if (word.length() > 0 && word.charAt(0) == c) {
                return true;
            }
        }
        if (result.length() > 0 && result.charAt(0) == c) {
            return true;
        }
        return false;
    }

    private int maxLength(String[] words, char result) {
        int max = 0;
        for (String word : words) {
            max = Math.max(max, word.length());
        }
        max = Math.max(max, result.length());
        return max;
    }

    private boolean checkSolution(String[] words, char result, int[] mapping) {
        int[] sum = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            for (int j = 0; j < words[i].length(); j++) {
                char c = words[i].charAt(j);
                sum[i] += mapping[c - 'A'];
                sum[i] *= 10;
            }
            sum[i] /= 10;
        }

        int res = 0;
        for (int j = 0; j < result.length(); j++) {
            char c = result.charAt(j);
            res += mapping[c - 'A'];
            res *= 10;
        }
        res /= 10;

        int total = 0;
        for (int s : sum) {
            total += s;
        }

        return total == res;
    }
}
}