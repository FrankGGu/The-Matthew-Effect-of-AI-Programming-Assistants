class Solution {
    public int minTimeToType(String word) {
        int totalTime = 0;
        char currentChar = 'a';

        for (int i = 0; i < word.length(); i++) {
            char targetChar = word.charAt(i);

            int diff = Math.abs(currentChar - targetChar);
            int moveTime = Math.min(diff, 26 - diff);

            totalTime += moveTime;
            totalTime += 1; // For pressing the key

            currentChar = targetChar;
        }

        return totalTime;
    }
}