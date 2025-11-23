class Solution {
    private boolean[] usedDigits = new boolean[10];
    private int[] charToDigit = new int[26];
    private List<Character> uniqueChars = new ArrayList<>();

    public boolean isSolvable(String[] words, String result) {
        Set<Character> charSet = new HashSet<>();
        for (String word : words) {
            for (char c : word.toCharArray()) {
                charSet.add(c);
            }
        }
        for (char c : result.toCharArray()) {
            charSet.add(c);
        }
        if (charSet.size() > 10) return false;

        uniqueChars = new ArrayList<>(charSet);
        int[] firstChars = new int[uniqueChars.size()];
        for (int i = 0; i < uniqueChars.size(); i++) {
            char c = uniqueChars.get(i);
            for (String word : words) {
                if (word.length() > 1 && word.charAt(0) == c) {
                    firstChars[i] = 1;
                    break;
                }
            }
            if (result.length() > 1 && result.charAt(0) == c) {
                firstChars[i] = 1;
            }
        }

        return backtrack(words, result, 0, 0, firstChars);
    }

    private boolean backtrack(String[] words, String result, int charIdx, int sum, int[] firstChars) {
        if (charIdx == uniqueChars.size()) {
            return sum == 0;
        }

        char c = uniqueChars.get(charIdx);
        int start = firstChars[charIdx] == 1 ? 1 : 0;
        for (int d = start; d <= 9; d++) {
            if (!usedDigits[d]) {
                usedDigits[d] = true;
                charToDigit[c - 'A'] = d;
                int newSum = calculateSum(words, result, c, sum);
                if (backtrack(words, result, charIdx + 1, newSum, firstChars)) {
                    return true;
                }
                usedDigits[d] = false;
            }
        }
        return false;
    }

    private int calculateSum(String[] words, String result, char c, int sum) {
        for (String word : words) {
            for (int i = 0; i < word.length(); i++) {
                if (word.charAt(i) == c) {
                    sum += charToDigit[c - 'A'] * Math.pow(10, word.length() - 1 - i);
                }
            }
        }
        for (int i = 0; i < result.length(); i++) {
            if (result.charAt(i) == c) {
                sum -= charToDigit[c - 'A'] * Math.pow(10, result.length() - 1 - i);
            }
        }
        return sum;
    }
}