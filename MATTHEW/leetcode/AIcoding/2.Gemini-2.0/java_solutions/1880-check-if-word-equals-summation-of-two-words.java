class Solution {
    public boolean isSumEqual(String firstWord, String secondWord, String targetWord) {
        int first = getValue(firstWord);
        int second = getValue(secondWord);
        int target = getValue(targetWord);
        return first + second == target;
    }

    private int getValue(String word) {
        int value = 0;
        for (char c : word.toCharArray()) {
            value = value * 10 + (c - 'a');
        }
        return value;
    }
}