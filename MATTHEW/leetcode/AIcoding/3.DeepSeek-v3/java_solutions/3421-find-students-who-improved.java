import java.util.*;

class Solution {
    public List<Integer> findStudents(int[][] scores) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int[] score : scores) {
            int studentId = score[0];
            int testScore = score[1];
            map.putIfAbsent(studentId, new ArrayList<>());
            map.get(studentId).add(testScore);
        }

        List<Integer> result = new ArrayList<>();
        for (int studentId : map.keySet()) {
            List<Integer> studentScores = map.get(studentId);
            if (studentScores.size() < 2) {
                continue;
            }
            boolean improved = true;
            for (int i = 1; i < studentScores.size(); i++) {
                if (studentScores.get(i) <= studentScores.get(i - 1)) {
                    improved = false;
                    break;
                }
            }
            if (improved) {
                result.add(studentId);
            }
        }

        Collections.sort(result);
        return result;
    }
}