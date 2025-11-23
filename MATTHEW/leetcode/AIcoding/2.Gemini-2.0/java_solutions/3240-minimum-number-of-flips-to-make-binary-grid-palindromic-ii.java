import java.util.*;

class Solution {
    private int n;
    private int[][] grid;

    public int minFlips(int[][] grid) {
        this.grid = grid;
        this.n = grid.length;

        String start = "";
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                start += grid[i][j];
            }
        }

        String target = "";
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i >= n - 1 - i && j >= n - 1 - j) {
                    target += "0";
                } else {
                    target += "1";
                }
            }
        }

        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.offer(start);
        visited.add(start);
        int flips = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String curr = queue.poll();
                if (isPalindromic(curr)) {
                    return flips;
                }

                for (int j = 0; j < n * n; j++) {
                    String next = flip(curr, j);
                    if (!visited.contains(next)) {
                        queue.offer(next);
                        visited.add(next);
                    }
                }
            }
            flips++;
        }

        return -1;
    }

    private String flip(String s, int index) {
        char[] chars = s.toCharArray();
        chars[index] = (chars[index] == '0' ? '1' : '0');
        return new String(chars);
    }

    private boolean isPalindromic(String s) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int index = i * n + j;
                int mirrorIndex = (n - 1 - i) * n + (n - 1 - j);
                if (s.charAt(index) != s.charAt(mirrorIndex)) {
                    return false;
                }
            }
        }
        return true;
    }
}