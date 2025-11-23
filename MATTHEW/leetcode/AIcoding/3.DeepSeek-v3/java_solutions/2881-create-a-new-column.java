import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> createNewColumn(List<List<Integer>> data) {
        List<Integer> result = new ArrayList<>();
        for (List<Integer> row : data) {
            int sum = 0;
            for (int num : row) {
                sum += num;
            }
            result.add(sum);
        }
        return result;
    }
}