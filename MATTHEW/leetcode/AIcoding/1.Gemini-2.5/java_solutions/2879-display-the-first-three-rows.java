import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<String>> getFirstThreeRows(List<List<String>> table) {
        List<List<String>> result = new ArrayList<>();
        if (table == null || table.isEmpty()) {
            return result;
        }

        int rowsToTake = Math.min(table.size(), 3);
        for (int i = 0; i < rowsToTake; i++) {
            result.add(table.get(i));
        }
        return result;
    }
}