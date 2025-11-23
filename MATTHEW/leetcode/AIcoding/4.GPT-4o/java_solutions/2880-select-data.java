import java.util.*;

public class Solution {
    public List<List<String>> selectData(List<String> data) {
        List<List<String>> result = new ArrayList<>();
        Set<String> uniqueData = new HashSet<>(data);
        for (String item : uniqueData) {
            result.add(Collections.singletonList(item));
        }
        return result;
    }
}