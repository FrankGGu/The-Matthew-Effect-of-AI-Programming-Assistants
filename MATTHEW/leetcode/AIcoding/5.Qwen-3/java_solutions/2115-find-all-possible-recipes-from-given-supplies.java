public class Solution {

import java.util.*;

class Solution {
    public List<String> findAllRecipes(String[] recipes, String[] supplies, String[][] ingredients) {
        Map<String, List<String>> graph = new HashMap<>();
        Map<String, Integer> inDegree = new HashMap<>();
        Set<String> supplySet = new HashSet<>(Arrays.asList(supplies));

        for (int i = 0; i < recipes.length; i++) {
            String recipe = recipes[i];
            graph.put(recipe, new ArrayList<>());
            inDegree.put(recipe, 0);
            for (String ingredient : ingredients[i]) {
                if (!supplySet.contains(ingredient)) {
                    graph.get(recipe).add(ingredient);
                    inDegree.put(ingredient, inDegree.getOrDefault(ingredient, 0) + 1);
                }
            }
        }

        Queue<String> queue = new LinkedList<>();
        for (String recipe : inDegree.keySet()) {
            if (inDegree.get(recipe) == 0) {
                queue.add(recipe);
            }
        }

        List<String> result = new ArrayList<>();

        while (!queue.isEmpty()) {
            String current = queue.poll();
            result.add(current);
            for (String neighbor : graph.get(current)) {
                inDegree.put(neighbor, inDegree.get(neighbor) - 1);
                if (inDegree.get(neighbor) == 0) {
                    queue.add(neighbor);
                }
            }
        }

        return result;
    }
}
}