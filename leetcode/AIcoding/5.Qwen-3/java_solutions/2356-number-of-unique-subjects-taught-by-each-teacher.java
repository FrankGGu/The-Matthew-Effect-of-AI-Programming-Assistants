public class Solution {

import java.util.*;

public class TeacherSubjects {
    public static List<List<String>> findUniqueSubjects(List<List<String>> teachers) {
        Map<String, Set<String>> teacherSubjectMap = new HashMap<>();

        for (List<String> teacher : teachers) {
            String name = teacher.get(0);
            String subject = teacher.get(1);
            teacherSubjectMap.putIfAbsent(name, new HashSet<>());
            teacherSubjectMap.get(name).add(subject);
        }

        List<List<String>> result = new ArrayList<>();
        for (Map.Entry<String, Set<String>> entry : teacherSubjectMap.entrySet()) {
            List<String> row = new ArrayList<>();
            row.add(entry.getKey());
            row.add(String.valueOf(entry.getValue().size()));
            result.add(row);
        }

        return result;
    }
}
}