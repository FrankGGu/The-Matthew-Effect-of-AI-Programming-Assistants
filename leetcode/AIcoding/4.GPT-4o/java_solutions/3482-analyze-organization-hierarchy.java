import java.util.*;

class Employee {
    public int id;
    public List<Employee> subordinates;

    public Employee() {
        id = 0;
        subordinates = new ArrayList<Employee>();
    }

    public Employee(int id) {
        this.id = id;
        subordinates = new ArrayList<Employee>();
    }

    public Employee(int id, List<Employee> subordinates) {
        this.id = id;
        this.subordinates = subordinates;
    }
}

class Solution {
    public List<Double> getAverageSalary(List<Employee> employees, int targetId) {
        Map<Integer, Double> salaryMap = new HashMap<>();
        Map<Integer, Integer> countMap = new HashMap<>();

        for (Employee emp : employees) {
            dfs(emp, salaryMap, countMap);
        }

        double totalSalary = salaryMap.getOrDefault(targetId, 0.0);
        int count = countMap.getOrDefault(targetId, 0);
        List<Double> result = new ArrayList<>();

        result.add(count == 0 ? 0.0 : totalSalary / count);
        for (int id : countMap.keySet()) {
            if (countMap.get(id) > 0 && id != targetId) {
                result.add(salaryMap.get(id) / countMap.get(id));
            }
        }

        return result;
    }

    private void dfs(Employee emp, Map<Integer, Double> salaryMap, Map<Integer, Integer> countMap) {
        if (!salaryMap.containsKey(emp.id)) {
            salaryMap.put(emp.id, 0.0);
            countMap.put(emp.id, 0);
        }
        salaryMap.put(emp.id, salaryMap.get(emp.id) + emp.id); // Assuming salary is equal to employee id
        countMap.put(emp.id, countMap.get(emp.id) + 1);

        for (Employee sub : emp.subordinates) {
            dfs(sub, salaryMap, countMap);
        }
    }
}