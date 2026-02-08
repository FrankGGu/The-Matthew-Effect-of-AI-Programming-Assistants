class Solution {
    private int maxScore = 0;

    public int maxCompatibilitySum(int[][] students, int[][] mentors) {
        int n = students.length;
        boolean[] used = new boolean[n];
        backtrack(students, mentors, used, 0, 0);
        return maxScore;
    }

    private void backtrack(int[][] students, int[][] mentors, boolean[] used, int index, int currentScore) {
        if (index == students.length) {
            maxScore = Math.max(maxScore, currentScore);
            return;
        }

        for (int i = 0; i < mentors.length; i++) {
            if (!used[i]) {
                used[i] = true;
                int score = calculateScore(students[index], mentors[i]);
                backtrack(students, mentors, used, index + 1, currentScore + score);
                used[i] = false;
            }
        }
    }

    private int calculateScore(int[] student, int[] mentor) {
        int score = 0;
        for (int i = 0; i < student.length; i++) {
            if (student[i] == mentor[i]) {
                score++;
            }
        }
        return score;
    }
}