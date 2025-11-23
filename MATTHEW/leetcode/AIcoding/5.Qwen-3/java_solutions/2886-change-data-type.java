public class Solution {

import java.util.*;

public class Solution {
    public static void main(String[] args) {
        // Example usage
        List<List<Object>> data = new ArrayList<>();
        data.add(Arrays.asList(1, "one"));
        data.add(Arrays.asList(2, "two"));
        data.add(Arrays.asList(3, "three"));

        List<List<Object>> result = changeDataType(data);

        for (List<Object> row : result) {
            System.out.println(row);
        }
    }

    public static List<List<Object>> changeDataType(List<List<Object>> students) {
        List<List<Object>> result = new ArrayList<>();
        for (List<Object> student : students) {
            List<Object> row = new ArrayList<>();
            row.add((Integer) student.get(0));
            row.add((String) student.get(1));
            result.add(row);
        }
        return result;
    }
}
}