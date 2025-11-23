import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<Integer> findStudents(int[][] score) {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < score.length; i++) {
            if (score[i][1] > score[i][0]) {
                result.add(i);
            }
        }
        return result;
    }
}