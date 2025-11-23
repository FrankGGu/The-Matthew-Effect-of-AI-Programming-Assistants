public class Solution {

import java.util.*;

public class Solution {
    public boolean canVisitAllRooms(List<List<Integer>> rooms) {
        Set<Integer> visited = new HashSet<>();
        Stack<Integer> stack = new Stack<>();
        stack.push(0);
        visited.add(0);

        while (!stack.isEmpty()) {
            int current = stack.pop();
            for (int key : rooms.get(current)) {
                if (!visited.contains(key)) {
                    visited.add(key);
                    stack.push(key);
                }
            }
        }

        return visited.size() == rooms.size();
    }
}
}