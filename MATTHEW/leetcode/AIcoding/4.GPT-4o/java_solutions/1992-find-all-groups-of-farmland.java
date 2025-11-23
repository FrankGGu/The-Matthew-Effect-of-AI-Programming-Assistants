import java.util.ArrayList;
import java.util.List;

public class Solution {
    public int[][] findFarmland(int[][] land) {
        List<int[]> result = new ArrayList<>();
        int rows = land.length;
        int cols = land[0].length;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (land[i][j] == 1) {
                    int x1 = i, y1 = j;
                    while (i < rows && land[i][j] == 1) {
                        i++;
                    }
                    while (j < cols && land[x1][j] == 1) {
                        j++;
                    }
                    result.add(new int[]{x1, y1, i - 1, j - 1});
                }
            }
        }
        return result.toArray(new int[result.size()][]);
    }
}