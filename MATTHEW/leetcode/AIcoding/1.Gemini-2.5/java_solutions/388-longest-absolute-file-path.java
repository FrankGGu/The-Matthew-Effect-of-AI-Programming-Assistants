import java.util.HashMap;
import java.util.Map;

class Solution {
    public int lengthLongestPath(String input) {
        if (input == null || input.isEmpty()) {
            return 0;
        }

        // Map to store the length of the absolute path up to a directory at a certain level.
        // Key: level (0-indexed)
        // Value: length of the path ending at the directory at this level
        // pathLengths.get(level) will give the length of the parent directory's path for an item at 'level'.
        Map<Integer, Integer> pathLengths = new HashMap<>();
        // Initialize with a virtual root at level -1 having path length 0.
        // This makes calculations for level 0 items consistent.
        pathLengths.put(-1, 0); 
        int maxLength = 0;

        String[] entries = input.split("\n");

        for (String entry : entries) {
            // Calculate the level of the current item based on leading tabs.
            // The number of tabs directly corresponds to the level.
            // For example: "dir" has 0 tabs (level 0), "\tsubdir" has 1 tab (level 1).
            int level = 0;
            while (level < entry.length() && entry.charAt(level) == '\t') {
                level++;
            }

            // Extract the name of the file or directory by removing leading tabs.
            String name = entry.substring(level);
            int currentNameLength = name.length();

            // Calculate the full absolute path length for the current item.
            // It's the length of its parent's path + 1 (for the '/') + its own name length.
            // pathLengths.get(level - 1) gives the length of the path ending at the parent directory.
            int parentPathLength = pathLengths.get(level - 1);
            int currentFullPathLength = parentPathLength + currentNameLength;

            // If it's not the root level (level 0), we need to add 1 for the '/' separator.
            // The virtual root (level -1) does not have a '/', so for level 0 items, we don't add 1.
            if (level > 0) {
                currentFullPathLength += 1; // Add '/' separator
            }

            // Check if the current item is a file (contains a '.').
            if (name.contains(".")) {
                maxLength = Math.max(maxLength, currentFullPathLength);
            } else {
                // If it's a directory, store its full path length.
                // This length will be used by its children (at level + 1) as their parent path length.
                pathLengths.put(level, currentFullPathLength);
            }
        }

        return maxLength;
    }
}