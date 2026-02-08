import java.util.*;

class Solution {
    public List<Integer> topStudents(String[] positive_feedback, String[] negative_feedback, String[] report, int[] student_id, int k) {
        Set<String> positive = new HashSet<>(Arrays.asList(positive_feedback));
        Set<String> negative = new HashSet<>(Arrays.asList(negative_feedback));

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            if (a[1] != b[1]) {
                return b[1] - a[1];
            } else {
                return a[0] - b[0];
            }
        });

        for (int i = 0; i < report.length; i++) {
            String[] words = report[i].split(" ");
            int score = 0;
            for (String word : words) {
                if (positive.contains(word)) {
                    score += 3;
                } else if (negative.contains(word)) {
                    score -= 1;
                }
            }
            pq.offer(new int[]{student_id[i], score});
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < k && !pq.isEmpty(); i++) {
            result.add(pq.poll()[0]);
        }

        return result;
    }
}