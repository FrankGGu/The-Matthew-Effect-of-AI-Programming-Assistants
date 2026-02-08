import java.util.*;

public class Solution {
    public List<String> combineFiles(List<String> files) {
        Set<String> set = new HashSet<>(files);
        List<String> result = new ArrayList<>(set);
        Collections.sort(result);
        return result;
    }
}