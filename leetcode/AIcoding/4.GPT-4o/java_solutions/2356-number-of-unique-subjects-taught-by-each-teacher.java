import java.util.*;

public class Solution {
    public List<Integer> uniqueSubjectsPerTeacher(List<List<String>> subjects) {
        List<Integer> result = new ArrayList<>();
        for (List<String> subjectList : subjects) {
            Set<String> uniqueSubjects = new HashSet<>(subjectList);
            result.add(uniqueSubjects.size());
        }
        return result;
    }
}