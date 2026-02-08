class Solution {
    public boolean canTraverseAllPairs(int[] nums) {
        int n = nums.length;
        if (n == 1) return true;

        int maxVal = 0;
        for (int num : nums) {
            if (num == 1) return false;
            maxVal = Math.max(maxVal, num);
        }

        List<Integer>[] adj = new List[maxVal + 1];
        for (int i = 0; i <= maxVal; i++) {
            adj[i] = new ArrayList<>();
        }

        Map<Integer, List<Integer>> numToFactors = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int num = nums[i];
            List<Integer> factors = new ArrayList<>();
            int temp = num;
            for (int j = 2; j * j <= temp; j++) {
                if (temp % j == 0) {
                    factors.add(j);
                    while (temp % j == 0) {
                        temp /= j;
                    }
                }
            }
            if (temp > 1) {
                factors.add(temp);
            }
            numToFactors.put(i, factors);
        }

        for (int i = 0; i < n; i++) {
            List<Integer> factors1 = numToFactors.get(i);
            for (int factor : factors1) {
                for (int j = i + 1; j < n; j++) {
                    List<Integer> factors2 = numToFactors.get(j);
                    for (int factor2 : factors2) {
                        if (factor == factor2) {
                            adj[nums[i]].add(nums[j]);
                            adj[nums[j]].add(nums[i]);
                            break;
                        }
                    }
                }
            }
        }

        Set<Integer> visited = new HashSet<>();
        dfs(nums[0], adj, visited);

        return visited.size() == n;
    }

    private void dfs(int node, List<Integer>[] adj, Set<Integer> visited) {
        visited.add(node);
        for (int neighbor : adj[node]) {
            if (!visited.contains(neighbor)) {
                dfs(neighbor, adj, visited);
            }
        }
    }
}