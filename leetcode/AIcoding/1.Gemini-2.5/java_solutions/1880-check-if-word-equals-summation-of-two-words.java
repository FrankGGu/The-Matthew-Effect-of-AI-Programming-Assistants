class Solution {
    public boolean isSumEqual(String firstWord, String secondWord, String targetWord) {
        int value1 = convertToNumericalValue(firstWord);
        int value2 = convertToNumericalValue(secondWord);
        int value3 = convertToNumericalValue(targetWord);

        return (value1 + value2) == value3;
    }

    private int convertToNumericalValue(String word) {
        int numericalValue = 0;
        for (char c : word.toCharArray()) {
            numericalValue = numericalValue * 10 + (c - 'a');
        }
        return numericalValue;
    }
}