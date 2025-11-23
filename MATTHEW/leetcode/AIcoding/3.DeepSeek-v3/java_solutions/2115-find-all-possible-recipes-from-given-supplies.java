class Solution {
    public List<String> findAllRecipes(String[] recipes, List<List<String>> ingredients, String[] supplies) {
        Map<String, List<String>> graph = new HashMap<>();
        Map<String, Integer> inDegree = new HashMap<>();
        Set<String> supplySet = new HashSet<>(Arrays.asList(supplies));
        List<String> result = new ArrayList<>();

        for (int i = 0; i < recipes.length; i++) {
            String recipe = recipes[i];
            List<String> ingredientList = ingredients.get(i);
            for (String ingredient : ingredientList) {
                graph.computeIfAbsent(ingredient, k -> new ArrayList<>()).add(recipe);
                inDegree.put(recipe, inDegree.getOrDefault(recipe, 0) + 1);
            }
        }

        Queue<String> queue = new LinkedList<>(supplySet);

        while (!queue.isEmpty()) {
            String current = queue.poll();
            if (!graph.containsKey(current)) continue;
            for (String neighbor : graph.get(current)) {
                inDegree.put(neighbor, inDegree.get(neighbor) - 1);
                if (inDegree.get(neighbor) == 0) {
                    queue.offer(neighbor);
                    result.add(neighbor);
                }
            }
        }

        return result;
    }
}