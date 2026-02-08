import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<String> renameColumns(List<List<String>> data, List<String> newNames) {
        if (data == null || data.isEmpty() || newNames == null || newNames.isEmpty()) {
            return new ArrayList<>();
        }

        List<String> result = new ArrayList<>();
        for (List<String> row : data) {
            List<String> newRow = new ArrayList<>();
            for (int i = 0; i < row.size() && i < newNames.size(); i++) {
                newRow.add(newNames.get(i));
            }
            result.addAll(newRow);
            break; // Only process the first row (header)
        }

        return result;
    }
}