class Solution {
    public int longestSpecialPath(int[] parent, String s) {
        int n = parent.length;
        List<List<Integer>> children = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            children.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            children.get(parent[i]).add(i);
        }
        int[] max = new int[1];
        dfs(0, children, s, max);
        return max[0];
    }

    private int dfs(int node, List<List<Integer>> children, String s, int[] max) {
        int longest = 0;
        int secondLongest = 0;
        for (int child : children.get(node)) {
            int childLength = dfs(child, children, s, max);
            if (s.charAt(node) != s.charAt(child)) {
                if (childLength > longest) {
                    secondLongest = longest;
                    longest = childLength;
                } else if (childLength > secondLongest) {
                    secondLongest = childLength;
                }
            }
        }
        max[0] = Math.max(max[0], longest + secondLongest + 1);
        return longest + 1;
    }
}