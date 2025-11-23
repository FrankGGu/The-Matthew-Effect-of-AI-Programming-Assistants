class Solution {
    public int[] smallestMissingValueSubtree(int[] parents, int[] nums) {
        int n = parents.length;
        int[] res = new int[n];
        Arrays.fill(res, 1);
        int onePos = -1;
        for (int i = 0; i < n; i++) {
            if (nums[i] == 1) {
                onePos = i;
                break;
            }
        }
        if (onePos == -1) {
            return res;
        }
        List<List<Integer>> children = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            children.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            children.get(parents[i]).add(i);
        }
        Set<Integer> visited = new HashSet<>();
        int current = onePos;
        int missing = 1;
        while (current != -1) {
            dfs(current, children, nums, visited);
            while (visited.contains(missing)) {
                missing++;
            }
            res[current] = missing;
            current = parents[current];
        }
        return res;
    }

    private void dfs(int node, List<List<Integer>> children, int[] nums, Set<Integer> visited) {
        if (visited.contains(nums[node])) {
            return;
        }
        visited.add(nums[node]);
        for (int child : children.get(node)) {
            dfs(child, children, nums, visited);
        }
    }
}