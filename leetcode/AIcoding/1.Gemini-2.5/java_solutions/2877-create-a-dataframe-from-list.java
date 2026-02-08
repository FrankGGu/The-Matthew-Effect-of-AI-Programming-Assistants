import java.util.List;

class Solution {
    public DataFrame createDataFrame(List<List<String>> data, List<String> columns) {
        return new DataFrame(data, columns);
    }
}