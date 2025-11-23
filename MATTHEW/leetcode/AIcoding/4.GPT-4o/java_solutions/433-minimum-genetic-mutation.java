import java.util.*;

public class Solution {
    public int minMutation(String start, String end, String[] bank) {
        Set<String> bankSet = new HashSet<>(Arrays.asList(bank));
        if (!bankSet.contains(end)) return -1;

        char[] genes = {'A', 'C', 'G', 'T'};
        Queue<String> queue = new LinkedList<>();
        queue.add(start);
        int mutations = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(end)) return mutations;

                char[] currentGenes = current.toCharArray();
                for (int j = 0; j < currentGenes.length; j++) {
                    char original = currentGenes[j];
                    for (char gene : genes) {
                        if (gene != original) {
                            currentGenes[j] = gene;
                            String next = new String(currentGenes);
                            if (bankSet.contains(next)) {
                                bankSet.remove(next);
                                queue.add(next);
                            }
                        }
                    }
                    currentGenes[j] = original;
                }
            }
            mutations++;
        }
        return -1;
    }
}