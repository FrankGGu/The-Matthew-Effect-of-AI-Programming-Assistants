class ThroneInheritance {
    private Map<String, List<String>> familyTree;
    private Set<String> dead;
    private String king;

    public ThroneInheritance(String kingName) {
        familyTree = new HashMap<>();
        dead = new HashSet<>();
        king = kingName;
        familyTree.put(kingName, new ArrayList<>());
    }

    public void birth(String parentName, String childName) {
        familyTree.get(parentName).add(childName);
        familyTree.put(childName, new ArrayList<>());
    }

    public void death(String name) {
        dead.add(name);
    }

    public List<String> getInheritanceOrder() {
        List<String> order = new ArrayList<>();
        dfs(king, order);
        return order;
    }

    private void dfs(String current, List<String> order) {
        if (!dead.contains(current)) {
            order.add(current);
        }
        for (String child : familyTree.get(current)) {
            dfs(child, order);
        }
    }
}