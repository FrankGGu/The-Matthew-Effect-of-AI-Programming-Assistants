public class Solution {
    public boolean isPathCrossing(String path) {
        int x = 0, y = 0;
        java.util.Set<String> visited = new java.util.HashSet<>();
        visited.add("0,0");
        for (char c : path.toCharArray()) {
            switch (c) {
                case 'U':
                    y++;
                    break;
                case 'D':
                    y--;
                    break;
                case 'R':
                    x++;
                    break;
                case 'L':
                    x--;
                    break;
            }
            String key = x + "," + y;
            if (visited.contains(key)) {
                return true;
            }
            visited.add(key);
        }
        return false;
    }
}