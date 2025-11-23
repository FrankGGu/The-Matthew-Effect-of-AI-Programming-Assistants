import java.util.List;
import java.util.ArrayList;

class Solution {

    public List<List<Object>> dropMissingData(List<List<Object>> products) {
        List<List<Object>> result = new ArrayList<>();
        for (List<Object> row : products) {
            if (row.get(1) != null && !row.get(1).toString().trim().isEmpty()) {
                result.add(row);
            }
        }
        return result;
    }
}