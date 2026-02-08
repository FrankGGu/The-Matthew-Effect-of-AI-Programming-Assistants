import java.util.List;
import java.util.ArrayList;

class Solution {

    public List<List<Object>> createBonusColumn(List<List<Object>> df) {
        List<List<Object>> result = new ArrayList<>();
        for (List<Object> row : df) {
            List<Object> newRow = new ArrayList<>(row);
            int salary = (int) row.get(1);
            double bonus;
            if (salary <= 10000) {
                bonus = salary * 1.1;
            } else {
                bonus = salary * 1.05;
            }
            newRow.add(bonus);
            result.add(newRow);
        }
        return result;
    }
}