class Solution {
    public boolean isSumEqual(String firstWord, String secondWord, String targetWord) {
        return getValue(firstWord) + getValue(secondWord) == getValue(targetWord);
    }

    private int getValue(String word) {
        int value = 0;
        for (char c : word.toCharArray()) {
            value = value * 10 + (c - 'a');
        }
        return value;
    }
}