class TrieNode {
    Map<String, TrieNode> children;
    String value;

    public TrieNode() {
        children = new HashMap<>();
        value = null;
    }
}

class Router {
    private TrieNode root;

    public Router() {
        root = new TrieNode();
    }

    public void addRoute(String path, String value) {
        String[] parts = path.split("/");
        TrieNode node = root;
        for (String part : parts) {
            if (part.isEmpty()) continue;
            if (!node.children.containsKey(part)) {
                node.children.put(part, new TrieNode());
            }
            node = node.children.get(part);
        }
        node.value = value;
    }

    public String route(String path) {
        String[] parts = path.split("/");
        TrieNode node = root;
        for (String part : parts) {
            if (part.isEmpty()) continue;
            if (node.children.containsKey(part)) {
                node = node.children.get(part);
            } else {
                return null;
            }
        }
        return node.value;
    }
}