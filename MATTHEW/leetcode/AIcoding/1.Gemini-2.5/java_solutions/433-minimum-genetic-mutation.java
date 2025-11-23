import java.util.*;

class Solution {
    public int minMutation(String startGene, String endGene, String[] bank) {
        Set<String> bankSet = new HashSet<>(Arrays.asList(bank));

        if (!bankSet.contains(endGene)) {
            return -1;
        }

        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();

        queue.offer(startGene);
        visited.add(startGene);

        int mutations = 0;
        char[] nucleotides = {'A', 'C', 'G', 'T'};

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            for (int i = 0; i < levelSize; i++) {
                String currentGene = queue.poll();

                if (currentGene.equals(endGene)) {
                    return mutations;
                }

                char[] currentGeneChars = currentGene.toCharArray();
                for (int j = 0; j < currentGeneChars.length; j++) {
                    char originalChar = currentGeneChars[j];
                    for (char c : nucleotides) {
                        if (c == originalChar) continue;

                        currentGeneChars[j] = c;
                        String nextGene = new String(currentGeneChars);

                        if (bankSet.contains(nextGene) && !visited.contains(nextGene)) {
                            visited.add(nextGene);
                            queue.offer(nextGene);
                        }
                    }
                    currentGeneChars[j] = originalChar; // backtrack
                }
            }
            mutations++;
        }

        return -1;
    }
}