class Solution {
    private int longestPath = 1;

    public int longestPath(int[] parent, String s) {
        int n = parent.length;
        List<List<Integer>> children = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            children.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            children.get(parent[i]).add(i);
        }
        dfs(0, children, s);
        return longestPath;
    }

    private int dfs(int currentNode, List<List<Integer>> children, String s) {
        int max1 = 0;
        int max2 = 0;
        for (int child : children.get(currentNode)) {
            int childLength = dfs(child, children, s);
            if (s.charAt(currentNode) != s.charAt(child)) {
                if (childLength > max1) {
                    max2 = max1;
                    max1 = childLength;
                } else if (childLength > max2) {
                    max2 = childLength;
                }
            }
        }
        longestPath = Math.max(longestPath, max1 + max2 + 1);
        return max1 + 1;
    }
}