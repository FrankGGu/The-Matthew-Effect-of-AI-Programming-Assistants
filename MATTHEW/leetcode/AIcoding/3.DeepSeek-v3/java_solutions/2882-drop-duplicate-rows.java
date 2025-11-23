import java.util.HashSet;
import java.util.Set;

class Solution {
    public List<List<String>> dropDuplicateRows(List<List<String>> input) {
        Set<String> seen = new HashSet<>();
        List<List<String>> result = new ArrayList<>();

        for (List<String> row : input) {
            String rowString = String.join(",", row);
            if (!seen.contains(rowString)) {
                seen.add(rowString);
                result.add(row);
            }
        }

        return result;
    }
}