public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> intersection(List<List<Integer>> nums) {
        Set<Integer> common = new HashSet<>(nums.get(0));
        for (int i = 1; i < nums.size(); i++) {
            Set<Integer> current = new HashSet<>(nums.get(i));
            common.retainAll(current);
        }
        return new ArrayList<>(common);
    }
}
}