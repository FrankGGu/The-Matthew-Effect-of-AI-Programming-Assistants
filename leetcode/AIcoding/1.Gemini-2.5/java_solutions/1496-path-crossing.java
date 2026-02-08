import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean isPathCrossing(String path) {
        Set<String> visited = new HashSet<>();
        int x = 0;
        int y = 0;
        visited.add(x + "," + y);

        for (char move : path.toCharArray()) {
            if (move == 'N') {
                y++;
            } else if (move == 'S') {
                y--;
            } else if (move == 'E') {
                x++;
            } else if (move == 'W') {
                x--;
            }

            String currentCoord = x + "," + y;
            if (visited.contains(currentCoord)) {
                return true;
            }
            visited.add(currentCoord);
        }

        return false;
    }
}