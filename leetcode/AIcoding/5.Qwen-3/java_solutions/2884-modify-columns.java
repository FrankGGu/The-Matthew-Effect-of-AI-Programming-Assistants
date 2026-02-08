public class Solution {

import java.util.*;

public class ModifyColumns {
    public static void main(String[] args) {
        // Example usage
        List<List<String>> employees = new ArrayList<>();
        employees.add(Arrays.asList("John", "Doe", "30"));
        employees.add(Arrays.asList("Jane", "Smith", "25"));

        modifyColumns(employees);

        for (List<String> row : employees) {
            System.out.println(row);
        }
    }

    public static void modifyColumns(List<List<String>> employees) {
        for (List<String> row : employees) {
            String firstName = row.get(0);
            String lastName = row.get(1);
            row.set(0, lastName);
            row.set(1, firstName);
        }
    }
}
}