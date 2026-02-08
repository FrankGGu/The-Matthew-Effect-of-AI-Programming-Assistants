import java.util.List;
import java.util.Map;

class Solution {
    public List<Map<String, Object>> fillMissingData(List<Map<String, Object>> inputs) {
        for (Map<String, Object> row : inputs) {
            if (!row.containsKey("occupation")) {
                row.put("occupation", "Doctor");
            }
        }
        return inputs;
    }
}