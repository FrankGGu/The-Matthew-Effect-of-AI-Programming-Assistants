class Solution {
    private Map<Integer, Integer> freq;
    private int res;

    public int countPalindromePaths(List<Integer> parent, String s) {
        freq = new HashMap<>();
        freq.put(0, 1);
        res = 0;
        List<List<Integer>> tree = new ArrayList<>();
        for (int i = 0; i < parent.size(); i++) {
            tree.add(new ArrayList<>());
        }
        for (int i = 1; i < parent.size(); i++) {
            tree.get(parent.get(i)).add(i);
        }
        dfs(0, 0, tree, s);
        return res;
    }

    private void dfs(int node, int mask, List<List<Integer>> tree, String s) {
        for (int child : tree.get(node)) {
            int bit = s.charAt(child) - 'a';
            int newMask = mask ^ (1 << bit);
            res += freq.getOrDefault(newMask, 0);
            for (int i = 0; i < 26; i++) {
                res += freq.getOrDefault(newMask ^ (1 << i), 0);
            }
            freq.put(newMask, freq.getOrDefault(newMask, 0) + 1);
            dfs(child, newMask, tree, s);
        }
    }
}