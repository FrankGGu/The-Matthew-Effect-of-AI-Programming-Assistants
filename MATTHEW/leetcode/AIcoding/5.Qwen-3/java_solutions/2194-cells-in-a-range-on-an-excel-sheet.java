public class Solution {

import java.util.*;

public class Solution {
    public List<String> cellsInRange(String s) {
        List<String> result = new ArrayList<>();
        char startCol = s.charAt(0);
        char endCol = s.charAt(3);
        int startRow = Integer.parseInt(s.substring(1, 2));
        int endRow = Integer.parseInt(s.substring(4, 5));

        for (char c = startCol; c <= endCol; c++) {
            for (int r = startRow; r <= endRow; r++) {
                result.add(String.valueOf(c) + r);
            }
        }

        return result;
    }
}
}