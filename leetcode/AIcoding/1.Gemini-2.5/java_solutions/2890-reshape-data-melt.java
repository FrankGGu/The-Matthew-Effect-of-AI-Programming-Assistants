import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<List<String>> melt(List<List<String>> data, List<String> idCols, List<String> valueCols) {
        List<List<String>> result = new ArrayList<>();

        if (data == null || data.isEmpty()) {
            return result;
        }

        List<String> header = data.get(0);
        Map<String, Integer> headerMap = new HashMap<>();
        for (int i = 0; i < header.size(); i++) {
            headerMap.put(header.get(i), i);
        }

        List<Integer> idColIndices = new ArrayList<>();
        for (String idCol : idCols) {
            if (headerMap.containsKey(idCol)) {
                idColIndices.add(headerMap.get(idCol));
            }
        }

        List<String> newHeader = new ArrayList<>(idCols);
        newHeader.add("variable");
        newHeader.add("value");
        result.add(newHeader);

        for (int i = 1; i < data.size(); i++) {
            List<String> row = data.get(i);

            List<String> currentIdValues = new ArrayList<>();
            for (int idIdx : idColIndices) {
                currentIdValues.add(row.get(idIdx));
            }

            for (String valueColName : valueCols) {
                if (headerMap.containsKey(valueColName)) {
                    int valueColIdx = headerMap.get(valueColName);
                    String value = row.get(valueColIdx);

                    List<String> meltedRow = new ArrayList<>(currentIdValues);
                    meltedRow.add(valueColName);
                    meltedRow.add(value);
                    result.add(meltedRow);
                }
            }
        }

        return result;
    }
}