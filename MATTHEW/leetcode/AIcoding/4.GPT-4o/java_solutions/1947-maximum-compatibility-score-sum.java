import java.util.*;

public class Solution {
    public int maxCompatibilitySum(int[][] students, int[][] mentors) {
        int n = students.length;
        int[] score = new int[n];
        boolean[] used = new boolean[n];
        return backtrack(students, mentors, score, used, 0);
    }

    private int backtrack(int[][] students, int[][] mentors, int[] score, boolean[] used, int index) {
        if (index == score.length) {
            return Arrays.stream(score).sum();
        }
        int maxScore = 0;
        for (int i = 0; i < mentors.length; i++) {
            if (!used[i]) {
                used[i] = true;
                score[index] = calculateCompatibility(students[index], mentors[i]);
                maxScore = Math.max(maxScore, backtrack(students, mentors, score, used, index + 1));
                used[i] = false;
            }
        }
        return maxScore;
    }

    private int calculateCompatibility(int[] student, int[] mentor) {
        int compatibility = 0;
        for (int i = 0; i < student.length; i++) {
            compatibility += (student[i] == mentor[i]) ? 1 : 0;
        }
        return compatibility;
    }
}