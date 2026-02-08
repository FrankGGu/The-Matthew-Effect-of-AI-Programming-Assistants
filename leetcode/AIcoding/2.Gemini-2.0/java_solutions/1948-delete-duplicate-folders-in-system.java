import java.util.*;

class Solution {
    public List<List<String>> deleteDuplicateFolder(List<List<String>> paths) {
        Map<String, Node> signatureToNode = new HashMap<>();
        Node root = new Node();
        for (List<String> path : paths) {
            Node curr = root;
            for (String folder : path) {
                if (!curr.children.containsKey(folder)) {
                    curr.children.put(folder, new Node());
                }
                curr = curr.children.get(folder);
            }
        }

        getSignature(root, signatureToNode);

        Set<Node> toDelete = new HashSet<>();
        findToDelete(root, toDelete);

        List<List<String>> result = new ArrayList<>();
        collectPaths(root, new ArrayList<>(), result, toDelete);

        return result;
    }

    private String getSignature(Node node, Map<String, Node> signatureToNode) {
        if (node.children.isEmpty()) {
            return "";
        }

        List<String> signatures = new ArrayList<>();
        List<String> folders = new ArrayList<>(node.children.keySet());
        Collections.sort(folders);

        for (String folder : folders) {
            signatures.add(folder + "(" + getSignature(node.children.get(folder), signatureToNode) + ")");
        }

        String signature = String.join(",", signatures);

        if (signatureToNode.containsKey(signature)) {
            node.duplicate = true;
            signatureToNode.get(signature).duplicate = true;
        } else {
            signatureToNode.put(signature, node);
        }

        return signature;
    }

    private void findToDelete(Node node, Set<Node> toDelete) {
        for (Node child : node.children.values()) {
            findToDelete(child, toDelete);
        }
        if (node.duplicate) {
            toDelete.add(node);
        }
    }

    private void collectPaths(Node node, List<String> path, List<List<String>> result, Set<Node> toDelete) {
        if (toDelete.contains(node)) {
            return;
        }
        if (node != root) {
            result.add(new ArrayList<>(path));
        }

        List<String> folders = new ArrayList<>(node.children.keySet());
        Collections.sort(folders);

        for (String folder : folders) {
            path.add(folder);
            collectPaths(node.children.get(folder), path, result, toDelete);
            path.remove(path.size() - 1);
        }
    }

    static class Node {
        Map<String, Node> children = new HashMap<>();
        boolean duplicate = false;
    }
}