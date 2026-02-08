import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean isPathCrossing(String path) {
        Set<String> visited = new HashSet<>();
        int x = 0;
        int y = 0;
        visited.add("0,0");

        for (char c : path.toCharArray()) {
            if (c == 'N') {
                y++;
            } else if (c == 'S') {
                y--;
            } else if (c == 'E') {
                x++;
            } else {
                x--;
            }

            String current = x + "," + y;
            if (visited.contains(current)) {
                return true;
            }
            visited.add(current);
        }

        return false;
    }
}