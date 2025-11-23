class Solution {
    public boolean canTraverse(int[] nums) {
        int n = nums.length;
        boolean[] visited = new boolean[n];
        List<Integer> components = new ArrayList<>();
        Map<Integer, List<Integer>> graph = new HashMap<>();

        for (int i = 0; i < n; i++) {
            graph.putIfAbsent(nums[i], new ArrayList<>());
            for (int j = 0; j < n; j++) {
                if (i != j && gcd(nums[i], nums[j]) > 1) {
                    graph.get(nums[i]).add(nums[j]);
                }
            }
        }

        for (int num : nums) {
            if (!visited[Arrays.asList(nums).indexOf(num)]) {
                components.add(num);
                dfs(num, graph, visited, nums);
            }
        }

        for (int num : nums) {
            if (!visited[Arrays.asList(nums).indexOf(num)]) {
                return false;
            }
        }
        return true;
    }

    private void dfs(int node, Map<Integer, List<Integer>> graph, boolean[] visited, int[] nums) {
        visited[Arrays.asList(nums).indexOf(node)] = true;
        for (int neighbor : graph.get(node)) {
            if (!visited[Arrays.asList(nums).indexOf(neighbor)]) {
                dfs(neighbor, graph, visited, nums);
            }
        }
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}