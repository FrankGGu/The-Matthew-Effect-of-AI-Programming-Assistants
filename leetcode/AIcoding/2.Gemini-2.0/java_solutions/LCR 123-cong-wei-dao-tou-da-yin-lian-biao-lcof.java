import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int[][] sortTheStudents(int[][] score, int k) {
        Arrays.sort(score, Comparator.comparingInt(row -> -row[k]));
        return score;
    }
}