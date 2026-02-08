import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

class Solution {
    public List<List<Integer>> findUniqueSubjects(List<List<Integer>> teachers) {
        Map<Integer, Set<Integer>> teacherSubjects = new HashMap<>();

        for (List<Integer> teacherRecord : teachers) {
            int teacherId = teacherRecord.get(0);
            int subjectId = teacherRecord.get(1);

            teacherSubjects
                .computeIfAbsent(teacherId, k -> new HashSet<>())
                .add(subjectId);
        }

        List<List<Integer>> result = new ArrayList<>();
        for (Map.Entry<Integer, Set<Integer>> entry : teacherSubjects.entrySet()) {
            List<Integer> row = new ArrayList<>();
            row.add(entry.getKey());
            row.add(entry.getValue().size());
            result.add(row);
        }

        result.sort((a, b) -> a.get(0).compareTo(b.get(0)));

        return result;
    }
}