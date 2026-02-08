import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    Map<String, Integer> count;
    List<TreeNode> result;

    public List<TreeNode> findDuplicateSubtrees(TreeNode root) {
        count = new HashMap<>();
        result = new ArrayList<>();
        serialize(root);
        return result;
    }

    private String serialize(TreeNode node) {
        if (node == null) {
            return "#";
        }

        String subtreeString = node.val + "," + serialize(node.left) + "," + serialize(node.right);
        count.put(subtreeString, count.getOrDefault(subtreeString, 0) + 1);

        if (count.get(subtreeString) == 2) {
            result.add(node);
        }
        return subtreeString;
    }
}