class Solution {
    public int lengthLongestPath(String input) {
        String[] paths = input.split("\n");
        int[] stack = new int[paths.length + 1];
        int maxLen = 0;
        for (String s : paths) {
            int level = s.lastIndexOf("\t") + 1;
            int curLen = stack[level] + s.length() - level + 1;
            stack[level + 1] = curLen;
            if (s.contains(".")) {
                maxLen = Math.max(maxLen, curLen - 1);
            }
        }
        return maxLen;
    }
}