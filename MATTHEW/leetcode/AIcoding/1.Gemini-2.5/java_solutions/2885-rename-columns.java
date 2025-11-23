import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<List<String>> renameColumns(List<List<String>> table, String oldName, String newName) {
        if (table == null || table.isEmpty()) {
            return new ArrayList<>();
        }

        List<String> header = table.get(0);
        int columnIndex = -1;

        for (int i = 0; i < header.size(); i++) {
            if (header.get(i).equals(oldName)) {
                columnIndex = i;
                break;
            }
        }

        if (columnIndex == -1) {
            List<List<String>> result = new ArrayList<>();
            for (List<String> row : table) {
                result.add(new ArrayList<>(row));
            }
            return result;
        }

        List<List<String>> result = new ArrayList<>();

        List<String> newHeader = new ArrayList<>(header);
        newHeader.set(columnIndex, newName);
        result.add(newHeader);

        for (int i = 1; i < table.size(); i++) {
            result.add(new ArrayList<>(table.get(i)));
        }

        return result;
    }
}