import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class Solution {
    public List<List<Object>> numberOfUniqueSubjects(List<List<Object>> teacher) {
        Map<Integer, Integer> teacherSubjects = new HashMap<>();

        for (List<Object> row : teacher) {
            int teacherId = (int) row.get(0);
            teacherSubjects.put(teacherId, teacherSubjects.getOrDefault(teacherId, 0) | (1 << ((int)row.get(1))));
        }

        List<List<Object>> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : teacherSubjects.entrySet()) {
            int teacherId = entry.getKey();
            int subjects = entry.getValue();
            int count = 0;
            for (int i = 0; i < 32; i++) {
                if ((subjects & (1 << i)) != 0) {
                    count++;
                }
            }
            List<Object> row = new ArrayList<>();
            row.add(teacherId);
            row.add(count);
            result.add(row);
        }

        return result;
    }
}