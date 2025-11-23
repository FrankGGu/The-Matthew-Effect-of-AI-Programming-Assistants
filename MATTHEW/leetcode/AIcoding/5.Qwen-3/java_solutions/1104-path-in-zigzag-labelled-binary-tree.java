public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> pathInZigzagForm(int label) {
        List<Integer> path = new ArrayList<>();
        int current = label;
        while (current > 0) {
            path.add(current);
            int level = (int) (Math.log(current) / Math.log(2)) + 1;
            int parent = current / 2;
            if (level % 2 == 0) {
                int first = (1 << (level - 1));
                int last = (1 << level) - 1;
                parent = first + last - parent;
            }
            current = parent;
        }
        java.util.Collections.reverse(path);
        return path;
    }
}
}