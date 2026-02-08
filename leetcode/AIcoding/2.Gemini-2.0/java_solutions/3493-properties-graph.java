import java.util.*;

class Solution {
    public List<List<Integer>> propertiesGraph(int size, List<Integer> properties) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < size; i++) {
            adj.add(new ArrayList<>());
        }

        Map<Integer, List<Integer>> propertyToNodes = new HashMap<>();
        for (int i = 0; i < properties.size(); i++) {
            int property = properties.get(i);
            if (!propertyToNodes.containsKey(property)) {
                propertyToNodes.put(property, new ArrayList<>());
            }
            propertyToNodes.get(property).add(i);
        }

        for (List<Integer> nodes : propertyToNodes.values()) {
            for (int i = 0; i < nodes.size(); i++) {
                for (int j = i + 1; j < nodes.size(); j++) {
                    int u = nodes.get(i);
                    int v = nodes.get(j);
                    adj.get(u).add(v);
                    adj.get(v).add(u);
                }
            }
        }

        return adj;
    }
}