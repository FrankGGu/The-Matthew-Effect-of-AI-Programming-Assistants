class Solution {
    public int game(int[] guess, int[] answer) {
        int correctCount = 0;
        if (guess[0] == answer[0]) {
            correctCount++;
        }
        if (guess[1] == answer[1]) {
            correctCount++;
        }
        if (guess[2] == answer[2]) {
            correctCount++;
        }
        return correctCount;
    }
}