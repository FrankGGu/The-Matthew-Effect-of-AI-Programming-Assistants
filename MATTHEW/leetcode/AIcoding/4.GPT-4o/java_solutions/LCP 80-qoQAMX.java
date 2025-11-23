class Solution {
    public String[] findAllRecipes(String[] recipes, List<List<String>> ingredients, String[] supplies) {
        Set<String> supplySet = new HashSet<>(Arrays.asList(supplies));
        Map<String, List<String>> recipeMap = new HashMap<>();
        for (int i = 0; i < recipes.length; i++) {
            recipeMap.put(recipes[i], ingredients.get(i));
        }

        List<String> result = new ArrayList<>();
        Set<String> made = new HashSet<>();

        for (String recipe : recipes) {
            if (canMake(recipe, recipeMap, supplySet, made)) {
                result.add(recipe);
            }
        }

        return result.toArray(new String[0]);
    }

    private boolean canMake(String recipe, Map<String, List<String>> recipeMap, Set<String> supplySet, Set<String> made) {
        if (supplySet.contains(recipe) || made.contains(recipe)) {
            return true;
        }
        if (!recipeMap.containsKey(recipe)) {
            return false;
        }

        for (String ingredient : recipeMap.get(recipe)) {
            if (!canMake(ingredient, recipeMap, supplySet, made)) {
                return false;
            }
        }

        made.add(recipe);
        return true;
    }
}