class Solution {
    public int lengthLongestPath(String input) {
        String[] parts = input.split("\n");
        Map<Integer, Integer> pathLength = new HashMap<>();
        int maxLength = 0;

        for (String part : parts) {
            int level = part.lastIndexOf('\t') + 1;
            int nameLength = part.length() - level;
            if (part.contains(".")) {
                maxLength = Math.max(maxLength, pathLength.getOrDefault(level, 0) + nameLength);
            } else {
                pathLength.put(level + 1, pathLength.getOrDefault(level, 0) + nameLength + 1);
            }
        }

        return maxLength;
    }
}