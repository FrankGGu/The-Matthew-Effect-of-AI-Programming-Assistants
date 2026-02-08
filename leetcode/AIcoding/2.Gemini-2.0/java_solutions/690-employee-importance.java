import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Employee {
    public int id;
    public int importance;
    public List<Integer> subordinates;
};

class Solution {
    public int getImportance(List<Employee> employees, int id) {
        Map<Integer, Employee> map = new HashMap<>();
        for (Employee employee : employees) {
            map.put(employee.id, employee);
        }
        return dfs(map, id);
    }

    private int dfs(Map<Integer, Employee> map, int id) {
        Employee employee = map.get(id);
        int importance = employee.importance;
        for (int subordinateId : employee.subordinates) {
            importance += dfs(map, subordinateId);
        }
        return importance;
    }
}