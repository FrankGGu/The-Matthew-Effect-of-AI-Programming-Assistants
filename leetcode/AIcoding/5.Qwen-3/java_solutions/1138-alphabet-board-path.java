public class Solution {
    public List<Character> path = new ArrayList<>();

    public void dfs(int x, int y, String target, boolean[][] visited) {
        if (x < 0 || y < 0 || x >= 6 || y >= 5 || visited[x][y]) {
            return;
        }
        if (target.length() == 0) {
            return;
        }
        char c = target.charAt(0);
        int tx = c - 'a';
        int ty = tx / 5;
        tx = tx % 5;
        if (x == tx && y == ty) {
            path.add(c);
            dfs(x, y, target.substring(1), visited);
        } else {
            if (x > tx) {
                for (int i = 0; i < x - tx; i++) {
                    path.add('U');
                }
                dfs(tx, y, target, visited);
            } else if (x < tx) {
                for (int i = 0; i < tx - x; i++) {
                    path.add('D');
                }
                dfs(tx, y, target, visited);
            } else if (y > ty) {
                for (int i = 0; i < y - ty; i++) {
                    path.add('L');
                }
                dfs(x, ty, target, visited);
            } else if (y < ty) {
                for (int i = 0; i < ty - y; i++) {
                    path.add('R');
                }
                dfs(x, ty, target, visited);
            }
        }
    }

    public String alphabetBoardPath(String target, int x, int y, boolean[][] visited) {
        if (target.length() == 0) {
            return "";
        }
        char c = target.charAt(0);
        int tx = c - 'a';
        int ty = tx / 5;
        tx = tx % 5;
        if (x == tx && y == ty) {
            return c + alphabetBoardPath(target.substring(1), x, y, visited);
        } else {
            visited[x][y] = true;
            StringBuilder sb = new StringBuilder();
            if (x > tx) {
                for (int i = 0; i < x - tx; i++) {
                    sb.append('U');
                }
                sb.append(alphabetBoardPath(target, tx, y, visited));
            } else if (x < tx) {
                for (int i = 0; i < tx - x; i++) {
                    sb.append('D');
                }
                sb.append(alphabetBoardPath(target, tx, y, visited));
            } else if (y > ty) {
                for (int i = 0; i < y - ty; i++) {
                    sb.append('L');
                }
                sb.append(alphabetBoardPath(target, x, ty, visited));
            } else if (y < ty) {
                for (int i = 0; i < ty - y; i++) {
                    sb.append('R');
                }
                sb.append(alphabetBoardPath(target, x, ty, visited));
            }
            visited[x][y] = false;
            return sb.toString();
        }
    }

    public String alphabetBoardPath(String target) {
        boolean[][] visited = new boolean[6][5];
        return alphabetBoardPath(target, 0, 0, visited);
    }
}