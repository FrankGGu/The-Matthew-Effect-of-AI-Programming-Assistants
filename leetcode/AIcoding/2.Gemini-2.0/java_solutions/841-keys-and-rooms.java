import java.util.List;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean canVisitAllRooms(List<List<Integer>> rooms) {
        int n = rooms.size();
        Set<Integer> visited = new HashSet<>();
        visited.add(0);
        dfs(rooms, 0, visited);
        return visited.size() == n;
    }

    private void dfs(List<List<Integer>> rooms, int room, Set<Integer> visited) {
        for (int key : rooms.get(room)) {
            if (!visited.contains(key)) {
                visited.add(key);
                dfs(rooms, key, visited);
            }
        }
    }
}