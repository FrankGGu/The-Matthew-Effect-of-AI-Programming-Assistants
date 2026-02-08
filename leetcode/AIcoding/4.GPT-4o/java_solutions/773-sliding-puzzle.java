import java.util.*;

class Solution {
    public int slidingPuzzle(int[][] board) {
        String target = "123450";
        String start = board[0][0] + "" + board[0][1] + board[0][2] + board[1][0] + board[1][1] + board[1][2];
        if (start.equals(target)) return 0;

        int[][] directions = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
        int zeroIndex = start.indexOf('0');
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.offer(start);
        visited.add(start);
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(target)) return steps;

                int x = zeroIndex / 3, y = zeroIndex % 3;

                for (int[] dir : directions) {
                    int newX = x + dir[0], newY = y + dir[1];
                    if (newX >= 0 && newX < 2 && newY >= 0 && newY < 3) {
                        int newIndex = newX * 3 + newY;
                        char[] chars = current.toCharArray();
                        swap(chars, zeroIndex, newIndex);
                        String newConfig = new String(chars);
                        if (!visited.contains(newConfig)) {
                            visited.add(newConfig);
                            queue.offer(newConfig);
                        }
                        swap(chars, zeroIndex, newIndex);  // swap back
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    private void swap(char[] chars, int i, int j) {
        char temp = chars[i];
        chars[i] = chars[j];
        chars[j] = temp;
    }
}