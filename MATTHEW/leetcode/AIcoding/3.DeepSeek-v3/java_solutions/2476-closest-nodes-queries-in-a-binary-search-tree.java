class Solution {
    public List<List<Integer>> closestNodes(TreeNode root, List<Integer> queries) {
        List<Integer> sorted = new ArrayList<>();
        inorder(root, sorted);
        List<List<Integer>> result = new ArrayList<>();
        for (int query : queries) {
            List<Integer> res = new ArrayList<>();
            int idx = Collections.binarySearch(sorted, query);
            if (idx >= 0) {
                res.add(query);
                res.add(query);
            } else {
                idx = -idx - 1;
                if (idx == 0) {
                    res.add(-1);
                    res.add(sorted.get(0));
                } else if (idx == sorted.size()) {
                    res.add(sorted.get(sorted.size() - 1));
                    res.add(-1);
                } else {
                    res.add(sorted.get(idx - 1));
                    res.add(sorted.get(idx));
                }
            }
            result.add(res);
        }
        return result;
    }

    private void inorder(TreeNode root, List<Integer> sorted) {
        if (root == null) return;
        inorder(root.left, sorted);
        sorted.add(root.val);
        inorder(root.right, sorted);
    }
}