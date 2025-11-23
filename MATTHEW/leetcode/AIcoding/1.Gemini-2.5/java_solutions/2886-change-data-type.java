import java.util.List;
import java.util.stream.Collectors;

class Solution {
    public List<Integer> changeDataType(List<String> columnData) {
        return columnData.stream()
                         .map(Integer::parseInt)
                         .collect(Collectors.toList());
    }
}