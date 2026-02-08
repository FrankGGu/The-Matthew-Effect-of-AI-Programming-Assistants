class Solution {
    public String crackSafe(int n, int k) {
        StringBuilder res = new StringBuilder();
        for (int i = 0; i < n; i++) {
            res.append('0');
        }
        Set<String> visited = new HashSet<>();
        visited.add(res.toString());
        dfs(res, visited, n, k);
        return res.toString();
    }

    private boolean dfs(StringBuilder res, Set<String> visited, int n, int k) {
        if (visited.size() == Math.pow(k, n)) {
            return true;
        }
        String prefix = res.substring(res.length() - n + 1);
        for (int i = 0; i < k; i++) {
            String next = prefix + i;
            if (!visited.contains(next)) {
                visited.add(next);
                res.append(i);
                if (dfs(res, visited, n, k)) {
                    return true;
                }
                visited.remove(next);
                res.setLength(res.length() - 1);
            }
        }
        return false;
    }
}