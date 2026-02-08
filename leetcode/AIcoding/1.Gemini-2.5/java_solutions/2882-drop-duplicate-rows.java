import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public DataFrame dropDuplicateRows(DataFrame df) {
        List<List<Integer>> originalRows = df.getRows();
        List<String> originalColumns = df.getColumns();

        Set<List<Integer>> seenRows = new HashSet<>();
        List<List<Integer>> uniqueRows = new ArrayList<>();

        for (List<Integer> row : originalRows) {
            if (seenRows.add(row)) {
                uniqueRows.add(row);
            }
        }

        return new DataFrame(uniqueRows, originalColumns);
    }
}