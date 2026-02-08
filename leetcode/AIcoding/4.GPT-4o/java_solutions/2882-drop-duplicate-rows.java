import java.util.*;

public class Solution {
    public List<List<String>> removeDuplicateRows(List<List<String>> rows) {
        Set<List<String>> set = new HashSet<>(rows);
        return new ArrayList<>(set);
    }
}