import java.util.*;

class Solution {

    static class Node {
        String name;
        Map<String, Node> children;
        boolean isDeleted;

        Node(String name) {
            this.name = name;
            this.children = new TreeMap<>();
            this.isDeleted = false;
        }
    }

    Map<String, List<Node>> hashToNodes;

    public List<List<String>> deleteDuplicateFolders(List<List<String>> paths) {
        Node dummyRoot = new Node("");
        hashToNodes = new HashMap<>();

        for (List<String> path : paths) {
            Node current = dummyRoot;
            for (String folderName : path) {
                current.children.putIfAbsent(folderName, new Node(folderName));
                current = current.children.get(folderName);
            }
        }

        for (Node child : dummyRoot.children.values()) {
            computeHashes(child);
        }

        for (List<Node> nodes : hashToNodes.values()) {
            if (nodes.size() > 1) {
                for (Node node : nodes) {
                    node.isDeleted = true;
                }
            }
        }

        List<List<String>> result = new ArrayList<>();
        List<String> currentPath = new ArrayList<>();

        for (Node child : dummyRoot.children.values()) {
            collectPaths(child, currentPath, result);
        }

        return result;
    }

    private String computeHashes(Node node) {
        StringBuilder sb = new StringBuilder();

        for (Map.Entry<String, Node> entry : node.children.entrySet()) {
            String childName = entry.getKey();
            Node childNode = entry.getValue();

            String childHash = computeHashes(childNode);

            sb.append("(").append(childName);
            sb.append(childHash);
            sb.append(")");
        }

        String hash = sb.toString();

        if (hash.isEmpty()) {
            hash = "()"; 
        }

        hashToNodes.computeIfAbsent(hash, k -> new ArrayList<>()).add(node);
        return hash;
    }

    private void collectPaths(Node node, List<String> currentPath, List<List<String>> result) {
        if (node.isDeleted) {
            return;
        }

        currentPath.add(node.name);
        result.add(new ArrayList<>(currentPath));

        for (Node child : node.children.values()) {
            collectPaths(child, currentPath, result);
        }

        currentPath.remove(currentPath.size() - 1);
    }
}