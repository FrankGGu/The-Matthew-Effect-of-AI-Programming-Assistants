class Solution {
    public int earliestFullMark(int[] marks) {
        int n = marks.length;
        int[] lastSeen = new int[101];
        int earliest = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            lastSeen[marks[i]] = i + 1; 
            if (allMarksSeen(lastSeen)) {
                earliest = Math.min(earliest, i + 1);
            }
        }

        return earliest == Integer.MAX_VALUE ? -1 : earliest;
    }

    private boolean allMarksSeen(int[] lastSeen) {
        for (int i = 1; i <= 100; i++) {
            if (lastSeen[i] == 0) {
                return false;
            }
        }
        return true;
    }
}