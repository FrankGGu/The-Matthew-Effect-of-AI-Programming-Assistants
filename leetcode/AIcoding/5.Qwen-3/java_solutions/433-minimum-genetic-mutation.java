public class Solution {

import java.util.*;

public class Solution {
    public int minMutation(String startGene, String endGene, String[] bank) {
        Set<String> bankSet = new HashSet<>(Arrays.asList(bank));
        char[] chars = {'A', 'C', 'G', 'T'};
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.add(startGene);
        visited.add(startGene);
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(endGene)) {
                    return steps;
                }
                for (char c : chars) {
                    for (int j = 0; j < 8; j++) {
                        StringBuilder sb = new StringBuilder(current);
                        sb.setCharAt(j, c);
                        String next = sb.toString();
                        if (bankSet.contains(next) && !visited.contains(next)) {
                            visited.add(next);
                            queue.add(next);
                        }
                    }
                }
            }
            steps++;
        }
        return -1;
    }
}
}