import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public List<Integer> pathInZigZagTree(int label) {
        int level = 0;
        int temp = label;
        while (temp > 0) {
            level++;
            temp /= 2;
        }

        List<Integer> path = new ArrayList<>();
        path.add(label);

        while (label > 1) {
            int min = (int) Math.pow(2, level - 2);
            int max = (int) Math.pow(2, level - 1) - 1;

            int parent = (min + max - (label / 2));
            path.add(parent);
            label = parent;
            level--;
        }

        Collections.reverse(path);
        return path;
    }
}