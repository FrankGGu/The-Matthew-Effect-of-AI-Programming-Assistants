import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> largeGroupPositions(String s) {
        List<List<Integer>> result = new ArrayList<>();
        int n = s.length();
        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && s.charAt(j) == s.charAt(i)) {
                j++;
            }
            if (j - i >= 3) {
                List<Integer> group = new ArrayList<>();
                group.add(i);
                group.add(j - 1);
                result.add(group);
            }
            i = j;
        }
        return result;
    }
}