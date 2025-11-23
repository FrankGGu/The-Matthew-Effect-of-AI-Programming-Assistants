import java.util.HashMap;

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public TreeNode createBinaryTree(int[][] descriptions) {
        HashMap<Integer, TreeNode> map = new HashMap<>();
        HashMap<Integer, Boolean> isChild = new HashMap<>();

        for (int[] desc : descriptions) {
            int parentVal = desc[0];
            int childVal = desc[1];
            boolean isLeft = desc[2] == 1;

            map.putIfAbsent(parentVal, new TreeNode(parentVal));
            map.putIfAbsent(childVal, new TreeNode(childVal));

            if (isLeft) {
                map.get(parentVal).left = map.get(childVal);
            } else {
                map.get(parentVal).right = map.get(childVal);
            }
            isChild.put(childVal, true);
        }

        for (int key : map.keySet()) {
            if (!isChild.getOrDefault(key, false)) {
                return map.get(key);
            }
        }

        return null;
    }
}