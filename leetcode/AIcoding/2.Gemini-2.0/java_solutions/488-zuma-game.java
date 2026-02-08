import java.util.LinkedList;

public class ZumaGame {
    public int findMinStep(String board, String hand) {
        int[] handCount = new int[26];
        for (char c : hand.toCharArray()) {
            handCount[c - 'A']++;
        }

        int result = dfs(board, handCount);
        return result == Integer.MAX_VALUE ? -1 : result;
    }

    private int dfs(String board, int[] handCount) {
        if (board.isEmpty()) {
            return 0;
        }

        int minSteps = Integer.MAX_VALUE;

        for (int i = 0; i < board.length(); i++) {
            int j = i;
            while (j < board.length() && board.charAt(i) == board.charAt(j)) {
                j++;
            }
            int need = 3 - (j - i);
            char c = board.charAt(i);
            if (handCount[c - 'A'] >= need) {
                handCount[c - 'A'] -= need;
                String nextBoard = clean(board.substring(0, i) + board.substring(j));
                int nextSteps = dfs(nextBoard, handCount);
                if (nextSteps != Integer.MAX_VALUE) {
                    minSteps = Math.min(minSteps, need + nextSteps);
                }
                handCount[c - 'A'] += need;
            }
        }

        return minSteps;
    }

    private String clean(String board) {
        if (board.isEmpty()) {
            return board;
        }

        LinkedList<Character> stack = new LinkedList<>();
        LinkedList<Integer> count = new LinkedList<>();

        for (char c : board.toCharArray()) {
            if (!stack.isEmpty() && stack.peekLast() == c) {
                count.set(count.size() - 1, count.peekLast() + 1);
            } else {
                stack.add(c);
                count.add(1);
            }

            while (!stack.isEmpty() && count.peekLast() >= 3) {
                stack.removeLast();
                count.removeLast();
            }
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < stack.size(); i++) {
            for (int j = 0; j < count.get(i); j++) {
                sb.append(stack.get(i));
            }
        }

        return sb.toString();
    }
}