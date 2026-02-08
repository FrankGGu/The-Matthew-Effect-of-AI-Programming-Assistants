class Solution {
    public int maximumScore(int a, int b, int c) {
        int[] stones = {a, b, c};
        Arrays.sort(stones);
        int score = 0;

        while (stones[2] > 0 && stones[1] > 0) {
            score++;
            stones[2]--;
            stones[1]--;
            Arrays.sort(stones);
        }

        return score;
    }
}