public class Solution {

import java.util.*;

public class Solution {
    public static List<Map<String, Object>> dropMissingData(List<Map<String, Object>> students) {
        List<Map<String, Object>> result = new ArrayList<>();
        for (Map<String, Object> student : students) {
            if (student.containsKey("name") && student.get("name") != null &&
                student.containsKey("age") && student.get("age") != null) {
                result.add(student);
            }
        }
        return result;
    }
}
}