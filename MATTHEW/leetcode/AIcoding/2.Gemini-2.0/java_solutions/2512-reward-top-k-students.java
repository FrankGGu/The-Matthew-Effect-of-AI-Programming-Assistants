import java.util.*;

class Solution {
    public List<Integer> rewardTopK(String[] positive_feedback, String[] negative_feedback, String[] report, int[] student_id, int k) {
        Set<String> positive = new HashSet<>(Arrays.asList(positive_feedback));
        Set<String> negative = new HashSet<>(Arrays.asList(negative_feedback));

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return b[1] - a[1];
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
            pq.offer(new int[]{score, student_id[i]});
            if (pq.size() > k) {
                pq.poll();
            }
        }

        List<Integer> result = new ArrayList<>();
        List<int[]> temp = new ArrayList<>();
        while (!pq.isEmpty()) {
            temp.add(pq.poll());
        }

        for (int i = temp.size() - 1; i >= 0; i--) {
            result.add(temp.get(i)[1]);
        }

        return result;
    }
}