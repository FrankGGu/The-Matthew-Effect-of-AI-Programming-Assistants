import java.util.*;

class Solution {
    public int slidingPuzzle(int[][] board) {
        String target = "123450";
        StringBuilder startBuilder = new StringBuilder();
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 3; j++) {
                startBuilder.append(board[i][j]);
            }
        }
        String start = startBuilder.toString();

        if (start.equals(target)) {
            return 0;
        }

        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();

        queue.offer(start);
        visited.add(start);

        int[][] moves = {
            {1, 3},    // 0 can move to 1, 3
            {0, 2, 4}, // 1 can move to 0, 2, 4
            {1, 5},    // 2 can move to 1, 5
            {0, 4},    // 3 can move to 0, 4
            {1, 3, 5}, // 4 can move to 1, 3, 5
            {2, 4}     // 5 can move to 2, 4
        };

        int level = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();

                if (current.equals(target)) {
                    return level;
                }

                int zeroPos = current.indexOf('0');

                for (int movePos : moves[zeroPos]) {
                    char[] chars = current.toCharArray();
                    char temp = chars[zeroPos];
                    chars[zeroPos] = chars[movePos];
                    chars[movePos] = temp;
                    String nextState = new String(chars);

                    if (!visited.contains(nextState)) {
                        visited.add(nextState);
                        queue.offer(nextState);
                    }
                }
            }
            level++;
        }

        return -1;
    }
}