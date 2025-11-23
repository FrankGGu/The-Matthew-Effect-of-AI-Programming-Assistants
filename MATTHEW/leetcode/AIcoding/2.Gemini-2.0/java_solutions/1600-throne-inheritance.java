import java.util.*;

class ThroneInheritance {

    private String kingName;
    private Map<String, List<String>> children;
    private Set<String> dead;

    public ThroneInheritance(String kingName) {
        this.kingName = kingName;
        this.children = new HashMap<>();
        this.dead = new HashSet<>();
    }

    public void birth(String parentName, String childName) {
        children.computeIfAbsent(parentName, k -> new ArrayList<>()).add(childName);
    }

    public void death(String name) {
        dead.add(name);
    }

    public List<String> getInheritanceOrder() {
        List<String> order = new ArrayList<>();
        dfs(kingName, order);
        return order;
    }

    private void dfs(String name, List<String> order) {
        if (!dead.contains(name)) {
            order.add(name);
        }

        List<String> childList = children.getOrDefault(name, new ArrayList<>());
        for (String child : childList) {
            dfs(child, order);
        }
    }
}