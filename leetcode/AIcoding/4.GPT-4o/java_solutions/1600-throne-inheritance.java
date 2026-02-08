import java.util.*;

class TreeNode {
    String name;
    TreeNode parent;
    List<TreeNode> children;

    public TreeNode(String name) {
        this.name = name;
        this.children = new ArrayList<>();
    }
}

class ThroneInheritance {
    private TreeNode king;
    private Set<String> dead;

    public ThroneInheritance(String kingName) {
        king = new TreeNode(kingName);
        dead = new HashSet<>();
    }

    public void birth(String parentName, String childName) {
        TreeNode parent = findNode(king, parentName);
        TreeNode child = new TreeNode(childName);
        parent.children.add(child);
        child.parent = parent;
    }

    public void death(String name) {
        dead.add(name);
    }

    public List<String> getInheritanceOrder() {
        List<String> order = new ArrayList<>();
        dfs(king, order);
        return order;
    }

    private void dfs(TreeNode node, List<String> order) {
        if (!dead.contains(node.name)) {
            order.add(node.name);
        }
        for (TreeNode child : node.children) {
            dfs(child, order);
        }
    }

    private TreeNode findNode(TreeNode node, String name) {
        if (node.name.equals(name)) {
            return node;
        }
        for (TreeNode child : node.children) {
            TreeNode found = findNode(child, name);
            if (found != null) {
                return found;
            }
        }
        return null;
    }
}