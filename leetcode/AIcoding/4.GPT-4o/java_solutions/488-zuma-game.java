class Solution {
    public int findMinStep(String board, String hand) {
        int[] handCount = new int[26];
        for (char c : hand.toCharArray()) {
            handCount[c - 'A']++;
        }
        return dfs(board, handCount);
    }

    private int dfs(String board, int[] handCount) {
        if (board.isEmpty()) return 0;
        board = removeConsecutive(board);
        int minSteps = Integer.MAX_VALUE;

        for (int i = 0; i < board.length(); i++) {
            for (int j = 1; j <= handCount[board.charAt(i) - 'A']; j++) {
                String nextBoard = board.substring(0, i) + board.substring(i + 1);
                handCount[board.charAt(i) - 'A'] -= j;
                nextBoard = removeConsecutive(nextBoard);
                int steps = dfs(nextBoard, handCount);
                if (steps != -1) {
                    minSteps = Math.min(minSteps, steps + j);
                }
                handCount[board.charAt(i) - 'A'] += j;
            }
        }
        return minSteps == Integer.MAX_VALUE ? -1 : minSteps;
    }

    private String removeConsecutive(String board) {
        StringBuilder sb = new StringBuilder();
        int count = 1;

        for (int i = 1; i <= board.length(); i++) {
            if (i < board.length() && board.charAt(i) == board.charAt(i - 1)) {
                count++;
            } else {
                if (count < 3) {
                    for (int j = 0; j < count; j++) {
                        sb.append(board.charAt(i - 1));
                    }
                }
                count = 1;
            }
        }
        return sb.toString();
    }
}