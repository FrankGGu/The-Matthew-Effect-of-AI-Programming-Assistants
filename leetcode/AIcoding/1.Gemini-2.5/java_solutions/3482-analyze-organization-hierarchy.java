import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {

    static class Employee {
        int id;
        String name;
        int managerId;

        Employee(int id, String name, int managerId) {
            this.id = id;
            this.name = name;
            this.managerId = managerId;
        }
    }

    public List<List<String>> analyzeOrganizationHierarchy(List<List<String>> employeesData) {
        Map<Integer, Employee> idToEmployee = new HashMap<>();
        Map<Integer, List<Integer>> adj = new HashMap<>();

        for (List<String> employeeData : employeesData) {
            int id = Integer.parseInt(employeeData.get(0));
            String name = employeeData.get(1);
            int managerId = Integer.parseInt(employeeData.get(2));

            Employee employee = new Employee(id, name, managerId);
            idToEmployee.put(id, employee);

            adj.computeIfAbsent(managerId, k -> new ArrayList<>()).add(id);
        }

        List<List<String>> result = new ArrayList<>();

        for (List<String> employeeData : employeesData) {
            int id = Integer.parseInt(employeeData.get(0));
            Employee currentEmployee = idToEmployee.get(id);

            int directSubordinates = adj.getOrDefault(currentEmployee.id, new ArrayList<>()).size();
            int totalSubordinates = calculateTotalSubordinates(currentEmployee.id, adj);

            String managerName = (currentEmployee.managerId == -1) ? "null" : idToEmployee.get(currentEmployee.managerId).name;

            List<String> employeeAnalysis = new ArrayList<>();
            employeeAnalysis.add(currentEmployee.name);
            employeeAnalysis.add(String.valueOf(currentEmployee.id));
            employeeAnalysis.add(String.valueOf(directSubordinates));
            employeeAnalysis.add(String.valueOf(totalSubordinates));
            employeeAnalysis.add(managerName);

            result.add(employeeAnalysis);
        }

        return result;
    }

    private int calculateTotalSubordinates(int employeeId, Map<Integer, List<Integer>> adj) {
        int count = 0;
        List<Integer> subordinates = adj.getOrDefault(employeeId, new ArrayList<>());
        for (int subId : subordinates) {
            count += 1 + calculateTotalSubordinates(subId, adj);
        }
        return count;
    }
}