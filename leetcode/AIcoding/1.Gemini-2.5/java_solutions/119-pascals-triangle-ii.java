import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> getRow(int rowIndex) {
        List<Integer> row = new ArrayList<>();
        long current = 1; 
        row.add((int) current); 

        for (int k = 1; k <= rowIndex; k++) {
            current = current * (rowIndex - k + 1) / k;
            row.add((int) current);
        }

        return row;
    }
}