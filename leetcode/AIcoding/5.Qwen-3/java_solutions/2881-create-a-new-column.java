public class Solution {

import java.util.Arrays;
import java.util.List;

public class Solution {
    public static void main(String[] args) {
        List<List<String>> employees = Arrays.asList(
            Arrays.asList("Alice", "25"),
            Arrays.asList("Bob", "30")
        );
        createNewColumn(employees);
    }

    public static void createNewColumn(List<List<String>> employees) {
        for (List<String> employee : employees) {
            String age = employee.get(1);
            employee.add(age + " years old");
        }
    }
}
}