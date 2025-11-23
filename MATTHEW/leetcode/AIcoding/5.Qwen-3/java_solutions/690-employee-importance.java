public class Solution {

import java.util.*;

class Employee {
    public int id;
    public int importance;
    public List<Integer> subordinates;
}

class Solution {
    public int getImportance(List<Employee> employees, int id) {
        Map<Integer, Employee> map = new HashMap<>();
        for (Employee e : employees) {
            map.put(e.id, e);
        }
        return dfs(map, id);
    }

    private int dfs(Map<Integer, Employee> map, int id) {
        int total = map.get(id).importance;
        for (int sub : map.get(id).subordinates) {
            total += dfs(map, sub);
        }
        return total;
    }
}
}