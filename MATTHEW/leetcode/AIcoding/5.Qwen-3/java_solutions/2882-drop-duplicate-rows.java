public class Solution {

import java.util.*;

public class Solution {
    public static void main(String[] args) {
        // Example usage
        String[][] data = {{"1", "Mason", "10"}, {"2", "Ava", "12"}, {"3", "Noah", "15"}, {"4", "Mason", "10"}};
        List<List<String>> df = new ArrayList<>();
        for (String[] row : data) {
            df.add(Arrays.asList(row));
        }
        List<List<String>> result = dropDuplicateRows(df);
        for (List<String> row : result) {
            System.out.println(row);
        }
    }

    public static List<List<String>> dropDuplicateRows(List<List<String>> df) {
        Set<String> seen = new HashSet<>();
        List<List<String>> result = new ArrayList<>();
        for (List<String> row : df) {
            StringBuilder key = new StringBuilder();
            for (String cell : row) {
                key.append(cell).append(",");
            }
            String rowKey = key.toString();
            if (!seen.contains(rowKey)) {
                seen.add(rowKey);
                result.add(row);
            }
        }
        return result;
    }
}
}