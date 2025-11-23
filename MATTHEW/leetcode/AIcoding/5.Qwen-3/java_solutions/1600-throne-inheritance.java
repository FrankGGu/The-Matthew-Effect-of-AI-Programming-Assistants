public class Solution {

import java.util.*;

class ThroneInheritance {
    private Map<String, List<String>> familyTree;
    private String kingName;
    private Set<String> dead;

    public ThroneInheritance(String kingName) {
        this.kingName = kingName;
        this.familyTree = new HashMap<>();
        this.dead = new HashSet<>();
    }

    public void birth(String parentName, String childName) {
        familyTree.putIfAbsent(parentName, new ArrayList<>());
        familyTree.get(parentName).add(childName);
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
        if (familyTree.containsKey(name)) {
            for (String child : familyTree.get(name)) {
                dfs(child, order);
            }
        }
    }
}
}