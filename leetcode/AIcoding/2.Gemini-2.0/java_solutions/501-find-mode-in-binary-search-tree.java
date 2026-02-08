import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int[] findMode(TreeNode root) {
        Map<Integer, Integer> counts = new HashMap<>();
        inorder(root, counts);

        int maxCount = 0;
        for (int count : counts.values()) {
            maxCount = Math.max(maxCount, count);
        }

        List<Integer> modes = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : counts.entrySet()) {
            if (entry.getValue() == maxCount) {
                modes.add(entry.getKey());
            }
        }

        int[] result = new int[modes.size()];
        for (int i = 0; i < modes.size(); i++) {
            result[i] = modes.get(i);
        }

        return result;
    }

    private void inorder(TreeNode root, Map<Integer, Integer> counts) {
        if (root == null) {
            return;
        }

        inorder(root.left, counts);
        counts.put(root.val, counts.getOrDefault(root.val, 0) + 1);
        inorder(root.right, counts);
    }
}