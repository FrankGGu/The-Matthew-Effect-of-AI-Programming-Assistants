class Solution {
    int m;
    int[][] compatibilityScores;
    int maxCompatibility;

    public int maxCompatibilitySum(int[][] students, int[][] mentors) {
        m = students.length;

        compatibilityScores = new int[m][m];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < m; j++) {
                compatibilityScores[i][j] = calculateCompatibility(students[i], mentors[j]);
            }
        }

        maxCompatibility = 0;
        backtrack(0, 0, 0);
        return maxCompatibility;
    }

    private int calculateCompatibility(int[] studentAnswers, int[] mentorAnswers) {
        int compatibility = 0;
        for (int i = 0; i < studentAnswers.length; i++) {
            if (studentAnswers[i] == mentorAnswers[i]) {
                compatibility++;
            }
        }
        return compatibility;
    }

    private void backtrack(int studentIndex, int currentScore, int usedMentorsMask) {
        if (studentIndex == m) {
            maxCompatibility = Math.max(maxCompatibility, currentScore);
            return;
        }

        for (int mentorIndex = 0; mentorIndex < m; mentorIndex++) {
            if ((usedMentorsMask & (1 << mentorIndex)) == 0) {
                backtrack(studentIndex + 1, currentScore + compatibilityScores[studentIndex][mentorIndex], usedMentorsMask | (1 << mentorIndex));
            }
        }
    }
}