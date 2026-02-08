class Solution {
    public boolean[] canReach(int[][] instructions, int startPos) {
        int n = instructions.length;
        boolean[] result = new boolean[n];
        int[] visited = new int[n];

        for (int i = 0; i < n; i++) {
            if (visited[i] == 0) {
                checkReachability(instructions, visited, i);
            }
            result[i] = visited[i] == 1;
        }

        return result;
    }

    private void checkReachability(int[][] instructions, int[] visited, int index) {
        int n = instructions.length;
        int currIndex = index;
        while (currIndex >= 0 && currIndex < n && visited[currIndex] == 0) {
            visited[currIndex] = 1;
            currIndex += instructions[currIndex][0] == 1 ? 1 : -1;
        }
    }
}