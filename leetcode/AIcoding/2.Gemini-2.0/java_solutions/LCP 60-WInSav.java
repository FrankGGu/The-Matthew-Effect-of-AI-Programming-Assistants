import java.util.*;

class Solution {
    public int minMoves(int[][] board) {
        int m = board.length;
        int n = board[0].length;
        List<Integer> list = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (board[0][i] != 0) {
                list.add(board[0][i]);
            }
        }
        for (int i = 1; i < m; i++) {
            if (i % 2 == 1) {
                for (int j = n - 1; j >= 0; j--) {
                    if (board[i][j] != 0) {
                        list.add(board[i][j]);
                    }
                }
            } else {
                for (int j = 0; j < n; j++) {
                    if (board[i][j] != 0) {
                        list.add(board[i][j]);
                    }
                }
            }
        }

        Queue<List<Integer>> queue = new LinkedList<>();
        queue.offer(list);
        Set<List<Integer>> visited = new HashSet<>();
        visited.add(list);
        int moves = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                List<Integer> current = queue.poll();
                if (current.isEmpty()) {
                    return moves;
                }

                for (int j = 0; j <= current.size(); j++) {
                    List<Integer> next = new ArrayList<>(current);
                    next.add(j, 1); // Assume the ball is always 1 for simplicity

                    while (true) {
                        int k = 0;
                        while (k < next.size()) {
                            int l = k;
                            while (l < next.size() && next.get(k).equals(next.get(l))) {
                                l++;
                            }
                            if (l - k >= 3) {
                                next.subList(k, l).clear();
                                if (next.isEmpty()) break;
                                k = 0;

                            } else {
                                k++;
                            }
                        }
                        break;
                    }

                    if (!visited.contains(next)) {
                        queue.offer(next);
                        visited.add(next);
                    }
                }
            }
            moves++;
        }

        return -1;
    }
}