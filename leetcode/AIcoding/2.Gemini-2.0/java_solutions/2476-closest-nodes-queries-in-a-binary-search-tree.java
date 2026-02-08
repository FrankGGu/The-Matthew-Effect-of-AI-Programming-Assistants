import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> closestNodes(TreeNode root, List<Integer> queries) {
        List<Integer> inorder = new ArrayList<>();
        inorderTraversal(root, inorder);
        List<List<Integer>> result = new ArrayList<>();
        for (int query : queries) {
            int lower = -1;
            int upper = -1;
            int low = 0;
            int high = inorder.size() - 1;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (inorder.get(mid) == query) {
                    lower = query;
                    upper = query;
                    break;
                } else if (inorder.get(mid) < query) {
                    lower = inorder.get(mid);
                    low = mid + 1;
                } else {
                    upper = inorder.get(mid);
                    high = mid - 1;
                }
            }
            if (lower == query && upper == query) {
                result.add(List.of(lower, upper));
            } else {
                low = 0;
                high = inorder.size() - 1;
                while (low <= high) {
                    int mid = low + (high - low) / 2;
                    if (inorder.get(mid) < query) {
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }
                if (high >= 0) {
                    lower = inorder.get(high);
                } else {
                    lower = -1;
                }

                low = 0;
                high = inorder.size() - 1;
                while (low <= high) {
                    int mid = low + (high - low) / 2;
                    if (inorder.get(mid) > query) {
                        high = mid - 1;
                    } else {
                        low = mid + 1;
                    }
                }
                if (low < inorder.size()) {
                    upper = inorder.get(low);
                } else {
                    upper = -1;
                }

                result.add(List.of(lower, upper));
            }
        }
        return result;
    }

    private void inorderTraversal(TreeNode root, List<Integer> inorder) {
        if (root == null) {
            return;
        }
        inorderTraversal(root.left, inorder);
        inorder.add(root.val);
        inorderTraversal(root.right, inorder);
    }
}