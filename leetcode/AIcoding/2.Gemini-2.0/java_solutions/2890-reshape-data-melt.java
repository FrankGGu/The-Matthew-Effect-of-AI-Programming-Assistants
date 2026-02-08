import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<String>> melt(List<List<String>> content) {
        List<List<String>> result = new ArrayList<>();
        List<String> header = content.get(0);
        for (int i = 1; i < content.size(); i++) {
            List<String> row = content.get(i);
            for (int j = 1; j < row.size(); j++) {
                List<String> newRow = new ArrayList<>();
                newRow.add(row.get(0));
                newRow.add(header.get(j));
                newRow.add(row.get(j));
                result.add(newRow);
            }
        }
        return result;
    }
}