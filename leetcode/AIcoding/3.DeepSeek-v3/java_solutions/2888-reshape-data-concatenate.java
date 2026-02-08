import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<List<Integer>> concatenateTables(List<List<Integer>> table1, List<List<Integer>> table2) {
        List<List<Integer>> result = new ArrayList<>();
        result.addAll(table1);
        result.addAll(table2);
        return result;
    }
}