class Solution {
    public int findMinStep(String board, String hand) {
        int[] handCount = new int[26];
        for (char c : hand.toCharArray()) {
            handCount[c - 'A']++;
        }
        int result = dfs(board + "#", handCount);
        return result == 6 ? -1 : result;
    }

    private int dfs(String s, int[] handCount) {
        s = removeConsecutive(s);
        if (s.equals("#")) return 0;
        int res = 6;
        for (int i = 0, j = 0; j < s.length(); j++) {
            if (s.charAt(j) == s.charAt(i)) continue;
            int needed = 3 - (j - i);
            if (handCount[s.charAt(i) - 'A'] >= needed) {
                handCount[s.charAt(i) - 'A'] -= needed;
                res = Math.min(res, needed + dfs(s.substring(0, i) + s.substring(j), handCount));
                handCount[s.charAt(i) - 'A'] += needed;
            }
            i = j;
        }
        return res;
    }

    private String removeConsecutive(String board) {
        for (int i = 0, j = 0; j < board.length(); j++) {
            if (board.charAt(j) == board.charAt(i)) continue;
            if (j - i >= 3) {
                return removeConsecutive(board.substring(0, i) + board.substring(j));
            }
            i = j;
        }
        return board;
    }
}