import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    Map<String, Integer> memo;
    int MAX_STEPS = 6; 

    public int findMinStep(String board, String hand) {
        memo = new HashMap<>();

        char[] handChars = hand.toCharArray();
        Arrays.sort(handChars);
        String sortedHand = new String(handChars);

        int result = dfs(board, sortedHand);

        return result >= MAX_STEPS ? -1 : result;
    }

    private int dfs(String board, String hand) {
        if (board.isEmpty()) {
            return 0;
        }

        String state = board + "#" + hand;
        if (memo.containsKey(state)) {
            return memo.get(state);
        }

        int minSteps = MAX_STEPS;

        for (int i = 0; i < hand.length(); i++) {
            char ballToInsert = hand.charAt(i);

            if (i > 0 && hand.charAt(i) == hand.charAt(i - 1)) {
                continue;
            }

            for (int j = 0; j <= board.length(); j++) {
                String newHand = hand.substring(0, i) + hand.substring(i + 1);

                String newBoard = board.substring(0, j) + ballToInsert + board.substring(j);

                String reducedBoard = reduce(newBoard);

                int res = dfs(reducedBoard, newHand);

                if (res != MAX_STEPS) {
                    minSteps = Math.min(minSteps, 1 + res);
                }
            }
        }

        memo.put(state, minSteps);
        return minSteps;
    }

    private String reduce(String s) {
        if (s.isEmpty()) return "";

        StringBuilder sb = new StringBuilder(s);
        boolean changed = true;

        while (changed) {
            changed = false;
            int i = 0;
            while (i < sb.length()) {
                int j = i;
                while (j < sb.length() && sb.charAt(j) == sb.charAt(i)) {
                    j++;
                }
                if (j - i >= 3) {
                    sb.delete(i, j);
                    changed = true;
                    i = 0; 
                } else {
                    i = j; 
                }
            }
        }
        return sb.toString();
    }
}