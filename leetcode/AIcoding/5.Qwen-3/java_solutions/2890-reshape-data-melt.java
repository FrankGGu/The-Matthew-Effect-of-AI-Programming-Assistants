public class Solution {

import java.util.*;

public class Solution {
    public static List<List<String>> melt(List<List<String>> df, String id_vars, String value_vars) {
        List<List<String>> result = new ArrayList<>();
        Set<String> idColumns = new HashSet<>(Arrays.asList(id_vars.split(",")));
        Set<String> valueColumns = new HashSet<>(Arrays.asList(value_vars.split(",")));

        List<String> header = new ArrayList<>();
        header.add("variable");
        header.add("value");
        result.add(header);

        for (List<String> row : df) {
            for (int i = 0; i < row.size(); i++) {
                String column = df.get(0).get(i);
                if (!idColumns.contains(column) && valueColumns.contains(column)) {
                    List<String> newRow = new ArrayList<>();
                    newRow.add(column);
                    newRow.add(row.get(i));
                    result.add(newRow);
                }
            }
        }

        return result;
    }
}
}