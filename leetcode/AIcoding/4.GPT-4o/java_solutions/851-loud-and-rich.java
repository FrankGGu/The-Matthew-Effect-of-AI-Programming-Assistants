import java.util.*;

class Solution {
    public int[] loudAndRich(int[][] richer, int[] quiet) {
        int n = quiet.length;
        List<List<Integer>> graph = new ArrayList<>();
        int[] inDegree = new int[n];

        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] r : richer) {
            graph.get(r[1]).add(r[0]);
            inDegree[r[0]]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        int[] answer = new int[n];
        Arrays.fill(answer, -1);

        while (!queue.isEmpty()) {
            int person = queue.poll();
            if (answer[person] == -1 || quiet[person] < quiet[answer[person]]) {
                answer[person] = person;
            }
            for (int richerPerson : graph.get(person)) {
                if (answer[richerPerson] == -1 || quiet[answer[person]] < quiet[answer[richerPerson]]) {
                    answer[richerPerson] = answer[person];
                }
                inDegree[richerPerson]--;
                if (inDegree[richerPerson] == 0) {
                    queue.offer(richerPerson);
                }
            }
        }

        return answer;
    }
}