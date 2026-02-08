class Solution {
    public int addMinimum(String word) {
        int numBlocks = 1;
        int expectedCharIndex = 0; // 0 for 'a', 1 for 'b', 2 for 'c'

        for (char c : word.toCharArray()) {
            int charVal = c - 'a';

            if (charVal == expectedCharIndex) {
                expectedCharIndex = (expectedCharIndex + 1) % 3;
            } else if (charVal > expectedCharIndex) {
                expectedCharIndex = (charVal + 1) % 3;
            } else { // charVal < expectedCharIndex
                numBlocks++;
                expectedCharIndex = (charVal + 1) % 3;
            }
        }

        return (numBlocks * 3) - word.length();
    }
}