import java.util.ArrayList;
import java.util.List;

class Solution {
    public boolean canFinish(int numCourses, int[][] prerequisites) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < numCourses; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] prerequisite : prerequisites) {
            adj.get(prerequisite[1]).add(prerequisite[0]);
        }

        // 0: unvisited, 1: visiting (in current DFS path), 2: visited (finished processing)
        int[] visited = new int[numCourses]; 

        for (int i = 0; i < numCourses; i++) {
            if (visited[i] == 0) { 
                if (!dfs(i, adj, visited)) {
                    return false; 
                }
            }
        }

        return true; 
    }

    private boolean dfs(int course, List<List<Integer>> adj, int[] visited) {
        visited[course] = 1; 

        for (int neighbor : adj.get(course)) {
            if (visited[neighbor] == 1) { 
                return false;
            }
            if (visited[neighbor] == 0) { 
                if (!dfs(neighbor, adj, visited)) {
                    return false; 
                }
            }
        }

        visited[course] = 2; 
        return true;
    }
}