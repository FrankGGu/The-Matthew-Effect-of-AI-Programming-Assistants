import java.util.*;

class Solution {
    public List<String> findAllRecipes(String[] recipes, List<List<String>> ingredients, String[] supplies) {
        // Set of all recipes for quick lookup
        Set<String> recipesSet = new HashSet<>(Arrays.asList(recipes));
        // Set of initial supplies for quick lookup
        Set<String> suppliesSet = new HashSet<>(Arrays.asList(supplies));

        // inDegree map: Stores the count of unavailable ingredients for each recipe.
        // A recipe can be made only when its inDegree becomes 0.
        Map<String, Integer> inDegree = new HashMap<>();

        // Adjacency list: ingredient -> list of recipes that depend on this ingredient.
        // When an ingredient becomes available, it can potentially help make these dependent recipes.
        Map<String, List<String>> adj = new HashMap<>();

        // Queue for BFS: Stores items (supplies or recipes) that are currently available.
        Queue<String> q = new LinkedList<>();

        // List to store the final makeable recipes.
        List<String> result = new ArrayList<>();

        // 1. Populate inDegree and adj maps
        for (int i = 0; i < recipes.length; i++) {
            String recipe = recipes[i];
            List<String> recipeIngredients = ingredients.get(i);
            int unavailableCount = 0;

            for (String ingredient : recipeIngredients) {
                // If an ingredient is not in the initial supplies, it's considered unavailable for now.
                // We count these as dependencies that need to be fulfilled.
                if (!suppliesSet.contains(ingredient)) {
                    unavailableCount++;
                    // Add an edge from the ingredient to the recipe, meaning the recipe depends on this ingredient.
                    adj.computeIfAbsent(ingredient, k -> new ArrayList<>()).add(recipe);
                }
            }
            inDegree.put(recipe, unavailableCount);
        }

        // 2. Initialize the queue with initially available items
        // First, add all initial supplies to the queue. They are immediately available.
        for (String supply : supplies) {
            q.offer(supply);
        }

        // Then, add recipes whose all ingredients are already in the initial supplies.
        // These recipes can be made immediately.
        for (String recipe : recipes) {
            if (inDegree.get(recipe) == 0) {
                q.offer(recipe);
            }
        }

        // 3. Perform BFS traversal
        while (!q.isEmpty()) {
            String currentAvailableItem = q.poll();

            // If the current available item is a recipe, it means all its ingredients are met.
            // So, this recipe can be made and should be added to the result.
            if (recipesSet.contains(currentAvailableItem)) {
                result.add(currentAvailableItem);
            }

            // Now, `currentAvailableItem` (either an initial supply or a newly made recipe)
            // can fulfill dependencies for other recipes.
            // Iterate through all recipes that depend on `currentAvailableItem`.
            for (String dependentRecipe : adj.getOrDefault(currentAvailableItem, Collections.emptyList())) {
                // Decrement the inDegree of the dependent recipe, as one of its ingredients is now available.
                inDegree.put(dependentRecipe, inDegree.get(dependentRecipe) - 1);

                // If the inDegree of the dependent recipe becomes 0, it means all its ingredients are now available.
                // This dependent recipe can now be made, so add it to the queue.
                if (inDegree.get(dependentRecipe) == 0) {
                    q.offer(dependentRecipe);
                }
            }
        }

        return result;
    }
}