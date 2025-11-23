import java.util.*;

class Solution {
    public List<String> findAllRecipes(String[] recipes, List<List<String>> ingredients, String[] supplies) {
        Set<String> supplySet = new HashSet<>(Arrays.asList(supplies));
        Map<String, List<String>> recipeMap = new HashMap<>();
        Map<String, Integer> inDegree = new HashMap<>();
        List<String> result = new ArrayList<>();

        for (int i = 0; i < recipes.length; i++) {
            inDegree.put(recipes[i], ingredients.get(i).size());
            recipeMap.put(recipes[i], ingredients.get(i));
        }

        Queue<String> queue = new LinkedList<>();
        for (String supply : supplies) {
            queue.offer(supply);
        }

        while (!queue.isEmpty()) {
            String currentSupply = queue.poll();
            for (String recipe : recipeMap.keySet()) {
                List<String> recipeIngredients = recipeMap.get(recipe);
                if (recipeIngredients.contains(currentSupply)) {
                    inDegree.put(recipe, inDegree.get(recipe) - 1);
                    if (inDegree.get(recipe) == 0) {
                        result.add(recipe);
                        queue.offer(recipe);
                    }
                }
            }
        }

        return result;
    }
}