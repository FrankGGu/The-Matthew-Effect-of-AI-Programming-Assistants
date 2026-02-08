class Solution {
    private List<Integer>[] graph;
    private int[] nums;
    private int[] res;
    private Map<Integer, List<int[]>> ancestors;

    public int[] getCoprimes(int[] nums, int[][] edges) {
        int n = nums.length;
        this.nums = nums;
        res = new int[n];
        Arrays.fill(res, -1);
        graph = new List[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph[u].add(v);
            graph[v].add(u);
        }
        ancestors = new HashMap<>();
        dfs(0, -1, 0);
        return res;
    }

    private void dfs(int node, int parent, int depth) {
        int maxDepth = -1;
        int closestAncestor = -1;
        for (int key : ancestors.keySet()) {
            if (gcd(nums[node], key) == 1) {
                List<int[]> nodes = ancestors.get(key);
                if (!nodes.isEmpty()) {
                    int[] last = nodes.get(nodes.size() - 1);
                    if (last[1] > maxDepth) {
                        maxDepth = last[1];
                        closestAncestor = last[0];
                    }
                }
            }
        }
        res[node] = closestAncestor;
        List<int[]> list = ancestors.getOrDefault(nums[node], new ArrayList<>());
        list.add(new int[]{node, depth});
        ancestors.put(nums[node], list);
        for (int child : graph[node]) {
            if (child != parent) {
                dfs(child, node, depth + 1);
            }
        }
        list.remove(list.size() - 1);
    }

    private int gcd(int a, int b) {
        return b == 0 ? a : gcd(b, a % b);
    }
}