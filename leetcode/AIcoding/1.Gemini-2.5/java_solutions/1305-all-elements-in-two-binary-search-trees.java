class Solution {
    public List<Integer> getAllElements(TreeNode root1, TreeNode root2) {
        List<Integer> list1 = new ArrayList<>();
        List<Integer> list2 = new ArrayList<>();

        inorderTraversal(root1, list1);
        inorderTraversal(root2, list2);

        List<Integer> result = new ArrayList<>();
        int p1 = 0;
        int p2 = 0;

        while (p1 < list1.size() && p2 < list2.size()) {
            if (list1.get(p1) <= list2.get(p2)) {
                result.add(list1.get(p1));
                p1++;
            } else {
                result.add(list2.get(p2));
                p2++;
            }
        }

        while (p1 < list1.size()) {
            result.add(list1.get(p1));
            p1++;
        }

        while (p2 < list2.size()) {
            result.add(list2.get(p2));
            p2++;
        }

        return result;
    }

    private void inorderTraversal(TreeNode node, List<Integer> list) {
        if (node == null) {
            return;
        }
        inorderTraversal(node.left, list);
        list.add(node.val);
        inorderTraversal(node.right, list);
    }
}