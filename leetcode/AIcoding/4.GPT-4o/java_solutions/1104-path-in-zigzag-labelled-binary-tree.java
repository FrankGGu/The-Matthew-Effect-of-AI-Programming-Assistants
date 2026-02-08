import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> pathInZigZagTree(int label) {
        List<Integer> path = new ArrayList<>();
        int level = 0;
        while ((1 << level) <= label) {
            level++;
        }
        for (int i = level; i > 0; i--) {
            path.add(label);
            int maxInLevel = (1 << i) - 1;
            int minInLevel = 1 << (i - 1);
            label = maxInLevel - (label - minInLevel) / 2;
        }
        Collections.reverse(path);
        return path;
    }
}