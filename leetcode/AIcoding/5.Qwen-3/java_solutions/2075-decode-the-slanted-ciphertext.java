public class Solution {

import java.util.*;

public class Solution {
    public String decodeCiphertext(String s, int rows) {
        if (rows == 0 || s.length() == 0) return "";
        int cols = (int) Math.ceil((double) s.length() / rows);
        char[][] grid = new char[rows][cols];
        int index = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (index < s.length()) {
                    grid[i][j] = s.charAt(index++);
                }
            }
        }
        StringBuilder result = new StringBuilder();
        for (int col = 0; col < cols; col++) {
            for (int i = 0; i < rows; i++) {
                int j = col + i;
                if (j < cols) {
                    result.append(grid[i][j]);
                }
            }
        }
        return result.toString();
    }
}
}