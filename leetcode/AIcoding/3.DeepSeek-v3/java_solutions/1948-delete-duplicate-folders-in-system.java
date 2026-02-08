class Solution {
    class TrieNode {
        Map<String, TrieNode> children = new HashMap<>();
        String name;
        boolean isDeleted = false;
    }

    public List<List<String>> deleteDuplicateFolder(List<List<String>> paths) {
        TrieNode root = new TrieNode();
        for (List<String> path : paths) {
            TrieNode node = root;
            for (String folder : path) {
                if (!node.children.containsKey(folder)) {
                    TrieNode newNode = new TrieNode();
                    newNode.name = folder;
                    node.children.put(folder, newNode);
                }
                node = node.children.get(folder);
            }
        }

        Map<String, TrieNode> seen = new HashMap<>();
        dedupe(root, seen);

        List<List<String>> result = new ArrayList<>();
        dfs(root, new ArrayList<>(), result);

        return result;
    }

    private String dedupe(TrieNode node, Map<String, TrieNode> seen) {
        StringBuilder keyBuilder = new StringBuilder();
        List<String> childKeys = new ArrayList<>();
        for (TrieNode child : node.children.values()) {
            childKeys.add(dedupe(child, seen));
        }
        Collections.sort(childKeys);
        for (String childKey : childKeys) {
            keyBuilder.append(childKey).append(",");
        }
        String key = keyBuilder.toString();
        if (!key.isEmpty()) {
            if (seen.containsKey(key)) {
                seen.get(key).isDeleted = true;
                node.isDeleted = true;
            } else {
                seen.put(key, node);
            }
        }
        return "(" + node.name + key + ")";
    }

    private void dfs(TrieNode node, List<String> path, List<List<String>> result) {
        for (Map.Entry<String, TrieNode> entry : node.children.entrySet()) {
            TrieNode child = entry.getValue();
            if (!child.isDeleted) {
                path.add(entry.getKey());
                result.add(new ArrayList<>(path));
                dfs(child, path, result);
                path.remove(path.size() - 1);
            }
        }
    }
}