import java.util.HashMap;

public class Solution {
    public boolean isSolvable(String[] words, String result) {
        HashMap<Character, Integer> charToValue = new HashMap<>();
        return backtrack(words, result, charToValue, new boolean[10], 0);
    }

    private boolean backtrack(String[] words, String result, HashMap<Character, Integer> charToValue, boolean[] used, int index) {
        if (index == words.length + 1) {
            return checkValidity(words, result, charToValue);
        }

        char currentChar = index < words.length ? words[index].charAt(0) : result.charAt(0);
        if (charToValue.containsKey(currentChar)) {
            return backtrack(words, result, charToValue, used, index + 1);
        }

        for (int i = 0; i < 10; i++) {
            if (used[i]) continue;
            if (index < words.length && i == 0 && words[index].length() > 1) continue;
            if (index == words.length && i == 0 && result.length() > 1) continue;

            charToValue.put(currentChar, i);
            used[i] = true;
            if (backtrack(words, result, charToValue, used, index + 1)) {
                return true;
            }
            used[i] = false;
            charToValue.remove(currentChar);
        }
        return false;
    }

    private boolean checkValidity(String[] words, String result, HashMap<Character, Integer> charToValue) {
        int sum = 0;
        for (String word : words) {
            sum += getValue(word, charToValue);
        }
        return sum == getValue(result, charToValue);
    }

    private int getValue(String word, HashMap<Character, Integer> charToValue) {
        int value = 0;
        for (char c : word.toCharArray()) {
            value = value * 10 + charToValue.get(c);
        }
        return value;
    }
}