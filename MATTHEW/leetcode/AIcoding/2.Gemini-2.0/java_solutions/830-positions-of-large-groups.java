import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> largeGroupPositions(String s) {
        List<List<Integer>> result = new ArrayList<>();
        int start = 0;
        for (int i = 0; i < s.length(); i++) {
            if (i == s.length() - 1 || s.charAt(i) != s.charAt(i + 1)) {
                if (i - start + 1 >= 3) {
                    List<Integer> group = new ArrayList<>();
                    group.add(start);
                    group.add(i);
                    result.add(group);
                }
                start = i + 1;
            }
        }
        return result;
    }
}