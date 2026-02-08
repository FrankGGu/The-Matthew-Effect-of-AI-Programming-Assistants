import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<String>> meltData(List<List<String>> df, String id_vars, String value_vars) {
        List<List<String>> result = new ArrayList<>();
        int idIndex = -1;
        int valueIndex = -1;

        if (df == null || df.isEmpty()) {
            return result;
        }

        List<String> header = df.get(0);
        for (int i = 0; i < header.size(); i++) {
            if (header.get(i).equals(id_vars)) {
                idIndex = i;
            }
            if (header.get(i).equals(value_vars)) {
                valueIndex = i;
            }
        }

        if (idIndex == -1 || valueIndex == -1) {
            return result;
        }

        List<String> newHeader = new ArrayList<>();
        newHeader.add("variable");
        newHeader.add("value");
        newHeader.add(id_vars);
        result.add(newHeader);

        for (int i = 1; i < df.size(); i++) {
            List<String> row = df.get(i);
            String idValue = row.get(idIndex);
            String valueValue = row.get(valueIndex);

            List<String> newRow = new ArrayList<>();
            newRow.add(value_vars);
            newRow.add(valueValue);
            newRow.add(idValue);
            result.add(newRow);
        }

        return result;
    }
}