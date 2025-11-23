import java.util.*;
import java.util.AbstractMap.SimpleEntry;

class Solution {
    public int openLock(String[] deadends, String target) {
        Set<String> deads = new HashSet<>(Arrays.asList(deadends));
        Set<String> visited = new HashSet<>();
        Queue<SimpleEntry<String, Integer>> q = new LinkedList<>();

        String start = "0000";

        if (deads.contains(start)) {
            return -1;
        }

        q.offer(new SimpleEntry<>(start, 0));
        visited.add(start);

        while (!q.isEmpty()) {
            SimpleEntry<String, Integer> current = q.poll();
            String currentCombination = current.getKey();
            int turns = current.getValue();

            if (currentCombination.equals(target)) {
                return turns;
            }

            for (int i = 0; i < 4; i++) {
                char c = currentCombination.charAt(i);

                // Rotate up
                char upChar = (char) (((c - '0' + 1) % 10) + '0');
                String upCombination = currentCombination.substring(0, i) + upChar + currentCombination.substring(i + 1);

                if (!visited.contains(upCombination) && !deads.contains(upCombination)) {
                    visited.add(upCombination);
                    q.offer(new SimpleEntry<>(upCombination, turns + 1));
                }

                // Rotate down
                char downChar = (char) (((c - '0' + 9) % 10) + '0'); // (c - '0' - 1 + 10) % 10
                String downCombination = currentCombination.substring(0, i) + downChar + currentCombination.substring(i + 1);

                if (!visited.contains(downCombination) && !deads.contains(downCombination)) {
                    visited.add(downCombination);
                    q.offer(new SimpleEntry<>(downCombination, turns + 1));
                }
            }
        }

        return -1;
    }
}