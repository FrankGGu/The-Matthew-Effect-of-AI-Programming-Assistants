class Solution {
    public int numTimesTarget(int[] scores, int target) {
        int count = 0;
        for (int score : scores) {
            if (score == target) {
                count++;
            }
        }
        return count;
    }
}