import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

class Solution {
    public List<Integer> topStudents(String[] positive_feedback, String[] negative_feedback, String[] report, int[] student_id, int k) {
        Set<String> positiveSet = new HashSet<>(Arrays.asList(positive_feedback));
        Set<String> negativeSet = new HashSet<>(Arrays.asList(negative_feedback));

        Map<Integer, Integer> studentScores = new HashMap<>();

        for (int i = 0; i < report.length; i++) {
            int currentStudentId = student_id[i];
            String[] words = report[i].split(" ");
            int currentScore = 0;

            for (String word : words) {
                if (positiveSet.contains(word)) {
                    currentScore += 3;
                } else if (negativeSet.contains(word)) {
                    currentScore -= 1;
                }
            }
            studentScores.put(currentStudentId, currentScore);
        }

        List<Student> students = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : studentScores.entrySet()) {
            students.add(new Student(entry.getKey(), entry.getValue()));
        }

        Collections.sort(students, (s1, s2) -> {
            if (s1.score != s2.score) {
                return s2.score - s1.score;
            } else {
                return s1.id - s2.id;
            }
        });

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < k; i++) {
            result.add(students.get(i).id);
        }

        return result;
    }

    private static class Student {
        int id;
        int score;

        public Student(int id, int score) {
            this.id = id;
            this.score = score;
        }
    }
}