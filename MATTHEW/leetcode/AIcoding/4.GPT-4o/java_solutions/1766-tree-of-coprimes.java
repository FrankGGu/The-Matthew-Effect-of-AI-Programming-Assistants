class Solution {
    public int[] getCoprimes(int[] nums, int[][] edges) {
        List<Integer>[] graph = new List[nums.length];
        for (int i = 0; i < nums.length; i++) graph[i] = new ArrayList<>();
        for (int[] edge : edges) {
            graph[edge[0]].add(edge[1]);
            graph[edge[1]].add(edge[0]);
        }

        int[] result = new int[nums.length];
        Arrays.fill(result, -1);

        boolean[] visited = new boolean[nums.length];
        dfs(0, -1, nums, visited, result, new HashMap<>(), 0);

        return result;
    }

    private void dfs(int node, int parent, int[] nums, boolean[] visited, int[] result, Map<Integer, Integer> coprimeMap, int depth) {
        visited[node] = true;
        int oldValue = coprimeMap.getOrDefault(nums[node], -1);

        for (int i = 0; i < 32; i++) {
            if ((nums[node] & (1 << i)) == 0) continue;
            for (int j = 0; j < 32; j++) {
                if ((i & (1 << j)) != 0) continue;
                if (coprimeMap.containsKey(1 << j)) {
                    int target = coprimeMap.get(1 << j);
                    if (target != -1) {
                        result[node] = target;
                    }
                }
            }
        }

        coprimeMap.put(nums[node], node);

        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, node, nums, visited, result, coprimeMap, depth + 1);
            }
        }

        if (oldValue == -1) {
            coprimeMap.remove(nums[node]);
        } else {
            coprimeMap.put(nums[node], oldValue);
        }
    }
}