import java.util.*;

public class Solution {
    public List<Integer> findStudents(int[] start, int[] end) {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < start.length; i++) {
            if (end[i] > start[i]) {
                result.add(i);
            }
        }
        return result;
    }
}