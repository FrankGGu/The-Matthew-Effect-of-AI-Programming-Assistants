public class Solution {

import java.util.*;

public class Solution {
    public List<List<String>> analyzeOrganizationHierarchy(List<String> employees, Map<String, String> reportsTo) {
        Map<String, List<String>> hierarchy = new HashMap<>();
        Set<String> allEmployees = new HashSet<>(employees);

        for (String employee : employees) {
            String manager = reportsTo.getOrDefault(employee, null);
            if (manager == null) {
                continue;
            }
            hierarchy.putIfAbsent(manager, new ArrayList<>());
            hierarchy.get(manager).add(employee);
        }

        List<List<String>> result = new ArrayList<>();
        Set<String> visited = new HashSet<>();

        for (String employee : employees) {
            if (!visited.contains(employee)) {
                List<String> level = new ArrayList<>();
                Queue<String> queue = new LinkedList<>();
                queue.add(employee);
                visited.add(employee);

                while (!queue.isEmpty()) {
                    int size = queue.size();
                    List<String> currentLevel = new ArrayList<>();

                    for (int i = 0; i < size; i++) {
                        String current = queue.poll();
                        currentLevel.add(current);

                        if (hierarchy.containsKey(current)) {
                            for (String sub : hierarchy.get(current)) {
                                if (!visited.contains(sub)) {
                                    visited.add(sub);
                                    queue.add(sub);
                                }
                            }
                        }
                    }

                    if (!currentLevel.isEmpty()) {
                        level.add(String.join(" ", currentLevel));
                    }
                }

                result.add(level);
            }
        }

        return result;
    }
}
}