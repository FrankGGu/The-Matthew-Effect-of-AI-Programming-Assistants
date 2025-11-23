import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<String>> dropMissingData(List<List<String>> data) {
        List<List<String>> result = new ArrayList<>();
        if (data == null || data.isEmpty()) {
            return result;
        }

        for (List<String> row : data) {
            boolean hasMissing = false;
            if (row == null) {
                hasMissing = true;
            } else {
                for (String cell : row) {
                    if (cell == null || cell.isEmpty()) {
                        hasMissing = true;
                        break;
                    }
                }
            }
            if (!hasMissing) {
                result.add(row);
            }
        }
        return result;
    }
}