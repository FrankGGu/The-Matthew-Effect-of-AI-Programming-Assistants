import java.util.*;

class Solution {
    public List<String> getManagers(int managementLevel, int employeeId, List<Employee> employees) {
        Map<Integer, Employee> employeeMap = new HashMap<>();
        for (Employee employee : employees) {
            employeeMap.put(employee.id, employee);
        }

        List<String> managers = new ArrayList<>();
        Employee current = employeeMap.get(employeeId);
        int level = 0;

        while (current != null && level < managementLevel) {
            current = employeeMap.get(current.managerId);
            if (current != null) {
                managers.add(current.name);
            }
            level++;
        }

        return managers;
    }

    static class Employee {
        public int id;
        public String name;
        public int managerId;

        public Employee(int id, String name, int managerId) {
            this.id = id;
            this.name = name;
            this.managerId = managerId;
        }
    }
}