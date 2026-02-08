import java.util.*;

class Solution {
    public int minMutation(String start, String end, String[] bank) {
        Set<String> bankSet = new HashSet<>(Arrays.asList(bank));
        if (!bankSet.contains(end)) {
            return -1;
        }

        Queue<String> queue = new LinkedList<>();
        queue.offer(start);
        Set<String> visited = new HashSet<>();
        visited.add(start);
        int mutations = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(end)) {
                    return mutations;
                }

                char[] chars = current.toCharArray();
                for (int j = 0; j < chars.length; j++) {
                    char original = chars[j];
                    char[] possibleChars = {'A', 'C', 'G', 'T'};
                    for (char c : possibleChars) {
                        chars[j] = c;
                        String next = new String(chars);
                        if (bankSet.contains(next) && !visited.contains(next)) {
                            queue.offer(next);
                            visited.add(next);
                        }
                    }
                    chars[j] = original;
                }
            }
            mutations++;
        }

        return -1;
    }
}