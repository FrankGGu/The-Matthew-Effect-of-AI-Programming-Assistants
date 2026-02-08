import java.util.*;

class Solution {
    public List<String> findAllRecipes(List<List<String>> recipes, List<String> ingredients, List<String> supplies) {
        Map<String, Integer> inDegree = new HashMap<>();
        Map<String, List<String>> adj = new HashMap<>();

        for (int i = 0; i < recipes.size(); i++) {
            String recipeName = ingredients.get(i); 
            List<String> requiredIngredients = recipes.get(i); 

            inDegree.put(recipeName, requiredIngredients.size());

            for (String requiredIng : requiredIngredients) {
                adj.computeIfAbsent(requiredIng, k -> new ArrayList<>()).add(recipeName);
            }
        }

        Queue<String> q = new LinkedList<>();
        List<String> result = new ArrayList<>();

        for (String supply : supplies) {
            q.offer(supply);
        }

        for (Map.Entry<String, Integer> entry : inDegree.entrySet()) {
            String recipeName = entry.getKey();
            if (entry.getValue() == 0) {
                q.offer(recipeName);
                result.add(recipeName);
            }
        }

        while (!q.isEmpty()) {
            String currentAvailableItem = q.poll();

            if (adj.containsKey(currentAvailableItem)) {
                for (String recipeUsingThisItem : adj.get(currentAvailableItem)) {
                    inDegree.put(recipeUsingThisItem, inDegree.get(recipeUsingThisItem) - 1);

                    if (inDegree.get(recipeUsingThisItem) == 0) {
                        result.add(recipeUsingThisItem);
                        q.offer(recipeUsingThisItem);
                    }
                }
            }
        }

        return result;
    }
}