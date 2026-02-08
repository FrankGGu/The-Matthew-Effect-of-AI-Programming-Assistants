class Solution {
    public int maxCompatibilitySum(int[][] students, int[][] mentors) {
        int m = students.length;
        int n = mentors.length;
        int k = students[0].length;
        int maxScore = 0;

        boolean[] used = new boolean[n];

        return solve(students, mentors, 0, used, 0);
    }

    private int solve(int[][] students, int[][] mentors, int studentIndex, boolean[] used, int currentScore) {
        if (studentIndex == students.length) {
            return currentScore;
        }

        int maxScore = 0;
        for (int i = 0; i < mentors.length; i++) {
            if (!used[i]) {
                used[i] = true;
                int score = calculateScore(students[studentIndex], mentors[i]);
                maxScore = Math.max(maxScore, solve(students, mentors, studentIndex + 1, used, currentScore + score));
                used[i] = false;
            }
        }
        return maxScore;
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