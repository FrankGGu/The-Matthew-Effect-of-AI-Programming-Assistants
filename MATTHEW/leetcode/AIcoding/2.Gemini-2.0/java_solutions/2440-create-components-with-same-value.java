class Solution {
    public int componentValue(int[] nums, int[][] edges) {
        int sum = 0;
        int max = 0;
        for (int num : nums) {
            sum += num;
            max = Math.max(max, num);
        }

        int n = nums.length;
        for (int k = n; k >= 1; k--) {
            if (sum % k == 0) {
                int target = sum / k;
                if (max > target) continue;

                List<Integer>[] adj = new List[n];
                for (int i = 0; i < n; i++) {
                    adj[i] = new ArrayList<>();
                }
                for (int[] edge : edges) {
                    adj[edge[0]].add(edge[1]);
                    adj[edge[1]].add(edge[0]);
                }

                int[] nodeSum = new int[n];
                Arrays.fill(nodeSum, 0);
                boolean possible = true;
                boolean[] visited = new boolean[n];

                for (int i = 0; i < n; i++) {
                    if (!visited[i]) {
                        if (!dfs(i, adj, nums, visited, nodeSum, target)) {
                            possible = false;
                            break;
                        }
                    }
                }

                if (possible) {
                    return k - 1;
                }
            }
        }

        return 0;
    }

    private boolean dfs(int node, List<Integer>[] adj, int[] nums, boolean[] visited, int[] nodeSum, int target) {
        visited[node] = true;
        nodeSum[node] = nums[node];

        for (int neighbor : adj[node]) {
            if (!visited[neighbor]) {
                if (!dfs(neighbor, adj, nums, visited, nodeSum, target)) {
                    return false;
                }
                nodeSum[node] += nodeSum[neighbor];
            }
        }

        if (nodeSum[node] > target) {
            return false;
        } else if (nodeSum[node] == target) {
            nodeSum[node] = 0;
        }

        return true;
    }
}