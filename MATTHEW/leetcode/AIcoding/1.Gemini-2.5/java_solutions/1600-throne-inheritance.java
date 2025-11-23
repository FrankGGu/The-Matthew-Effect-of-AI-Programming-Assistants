import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

class ThroneInheritance {

    private String kingName;
    private Map<String, List<String>> childrenMap;
    private Set<String> deadSet;

    public ThroneInheritance(String kingName) {
        this.kingName = kingName;
        this.childrenMap = new HashMap<>();
        this.deadSet = new HashSet<>();
        // Initialize the king in the family tree, even if they have no children yet
        this.childrenMap.put(kingName, new ArrayList<>());
    }

    public void birth(String parentName, String childName) {
        // Add child to parent's list of children
        childrenMap.computeIfAbsent(parentName, k -> new ArrayList<>()).add(childName);
        // Initialize the child in the family tree, even if they have no children yet
        childrenMap.putIfAbsent(childName, new ArrayList<>());
    }

    public void death(String name) {
        deadSet.add(name);
    }

    public List<String> getInheritanceOrder() {
        List<String> order = new ArrayList<>();
        dfs(kingName, order);
        return order;
    }

    private void dfs(String currentPerson, List<String> order) {
        // If the current person is not dead, add them to the inheritance order
        if (!deadSet.contains(currentPerson)) {
            order.add(currentPerson);
        }

        // Recursively visit children in their birth order
        // childrenMap.get(currentPerson) will return an empty list if no children, which is fine for the loop
        for (String child : childrenMap.getOrDefault(currentPerson, new ArrayList<>())) {
            dfs(child, order);
        }
    }
}