import java.util.*;

class DataFrame {
    private List<String> columns;
    private List<List<Object>> data;

    public DataFrame(List<String> columns) {
        this.columns = columns;
        this.data = new ArrayList<>();
    }

    public void addRow(List<Object> row) {
        data.add(row);
    }

    public List<String> getColumns() {
        return columns;
    }

    public List<List<Object>> getData() {
        return data;
    }
}

public class Solution {
    public DataFrame createDataFrame(List<String> columns, List<List<Object>> values) {
        DataFrame df = new DataFrame(columns);
        for (List<Object> row : values) {
            df.addRow(row);
        }
        return df;
    }
}