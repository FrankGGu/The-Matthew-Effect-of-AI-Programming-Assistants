import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> cellsInRange(String s) {
        char startCol = s.charAt(0);
        int startRow = s.charAt(1) - '0';
        char endCol = s.charAt(3);
        int endRow = s.charAt(4) - '0';

        List<String> result = new ArrayList<>();

        for (char col = startCol; col <= endCol; col++) {
            for (int row = startRow; row <= endRow; row++) {
                StringBuilder cell = new StringBuilder();
                cell.append(col);
                cell.append(row);
                result.add(cell.toString());
            }
        }
        return result;
    }
}