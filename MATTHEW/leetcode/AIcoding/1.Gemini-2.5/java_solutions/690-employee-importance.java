import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private Map<Integer, Employee> employeeMap;

    public int getImportance(List<Employee> employees, int id) {
        employeeMap = new HashMap<>();
        for (Employee emp : employees) {
            employeeMap.put(emp.id, emp);
        }

        return dfs(id);
    }

    private int dfs(int employeeId) {
        Employee employee = employeeMap.get(employeeId);
        if (employee == null) {
            return 0;
        }

        int totalImportance = employee.importance;
        for (int subordinateId : employee.subordinates) {
            totalImportance += dfs(subordinateId);
        }

        return totalImportance;
    }
}