import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<List<Object>> createDataFrame(List<Object> list) {
        List<List<Object>> result = new ArrayList<>();
        for (Object item : list) {
            List<Object> row = new ArrayList<>();
            row.add(item);
            result.add(row);
        }
        return result;
    }
}