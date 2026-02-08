import java.util.*;

class Solution {
    public List<String> findAllRecipes(String[] recipes, List<List<String>> ingredients, String[] supplies) {
        Set<String> supplySet = new HashSet<>(Arrays.asList(supplies));
        Map<String, List<String>> graph = new HashMap<>();
        Map<String, Integer> indegree = new HashMap<>();

        for (String recipe : recipes) {
            graph.put(recipe, new ArrayList<>());
            indegree.put(recipe, 0);
        }

        for (int i = 0; i < recipes.length; i++) {
            for (String ingredient : ingredients.get(i)) {
                if (graph.containsKey(ingredient)) {
                    graph.get(ingredient).add(recipes[i]);
                    indegree.put(recipes[i], indegree.get(recipes[i]) + 1);
                } else if (!supplySet.contains(ingredient)) {
                    indegree.put(recipes[i], indegree.get(recipes[i]) + 1);
                }
            }
        }

        Queue<String> queue = new LinkedList<>();
        for (String recipe : recipes) {
            if (indegree.get(recipe) == 0) {
                queue.offer(recipe);
            }
        }

        List<String> result = new ArrayList<>();
        while (!queue.isEmpty()) {
            String recipe = queue.poll();
            result.add(recipe);

            for (String neighbor : graph.getOrDefault(recipe, new ArrayList<>())) {
                indegree.put(neighbor, indegree.get(neighbor) - 1);
                if (indegree.get(neighbor) == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        return result;
    }
}