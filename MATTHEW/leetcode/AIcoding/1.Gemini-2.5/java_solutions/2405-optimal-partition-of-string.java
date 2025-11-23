import java.util.HashSet;
import java.util.Set;

class Solution {
    public int partitionString(String s) {
        int partitions = 0;
        Set<Character> currentPartitionChars = new HashSet<>();

        for (char c : s.toCharArray()) {
            if (currentPartitionChars.contains(c)) {
                partitions++;
                currentPartitionChars.clear();
            }
            currentPartitionChars.add(c);
        }

        if (!currentPartitionChars.isEmpty()) {
            partitions++;
        }

        return partitions;
    }
}