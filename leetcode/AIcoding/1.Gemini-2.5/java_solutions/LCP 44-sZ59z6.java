import java.util.List;

class Solution {
    public int fireworksCount(Node root) {
        if (root == null) {
            return 0;
        }
        int count = 1;
        if (root.children != null) {
            for (Node child : root.children) {
                count += fireworksCount(child);
            }
        }
        return count;
    }
}