class Solution {
    public int maxNumTargetNodes(int[] parent, int[] nums, int target) {
        int n = parent.length;
        List<List<Integer>> tree = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            tree.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            tree.get(parent[i]).add(i);
        }

        int[] count = new int[n];
        dfs(tree, nums, target, 0, count);

        int max = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] == target) {
                max = Math.max(max, count[i]);
            }
        }
        return max;
    }

    private void dfs(List<List<Integer>> tree, int[] nums, int target, int node, int[] count) {
        count[node] = nums[node] == target ? 1 : 0;
        for (int child : tree.get(node)) {
            dfs(tree, nums, target, child, count);
            count[node] += count[child];
        }
    }
}