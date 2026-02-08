import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

class Solution {
    public List<List<Integer>> findCategoryRecommendationPairs(List<List<Integer>> userCategoryPairs) {
        Map<Integer, Set<Integer>> userToCategories = new HashMap<>();
        for (List<Integer> pair : userCategoryPairs) {
            int userId = pair.get(0);
            int categoryId = pair.get(1);
            userToCategories.computeIfAbsent(userId, k -> new HashSet<>()).add(categoryId);
        }

        Map<Pair, Integer> pairCounts = new HashMap<>();

        for (Set<Integer> categories : userToCategories.values()) {
            if (categories.size() < 2) {
                continue;
            }

            List<Integer> sortedCategories = new ArrayList<>(categories);
            Collections.sort(sortedCategories);

            for (int i = 0; i < sortedCategories.size(); i++) {
                for (int j = i + 1; j < sortedCategories.size(); j++) {
                    int cat1 = sortedCategories.get(i);
                    int cat2 = sortedCategories.get(j);
                    Pair currentPair = new Pair(cat1, cat2);
                    pairCounts.put(currentPair, pairCounts.getOrDefault(currentPair, 0) + 1);
                }
            }
        }

        List<List<Integer>> result = new ArrayList<>();
        for (Map.Entry<Pair, Integer> entry : pairCounts.entrySet()) {
            Pair pair = entry.getKey();
            int count = entry.getValue();
            result.add(Arrays.asList(pair.cat1, pair.cat2, count));
        }

        Collections.sort(result, (a, b) -> {
            int cmp1 = Integer.compare(a.get(0), b.get(0));
            if (cmp1 != 0) {
                return cmp1;
            }
            return Integer.compare(a.get(1), b.get(1));
        });

        return result;
    }

    private static class Pair {
        int cat1;
        int cat2;

        public Pair(int cat1, int cat2) {
            this.cat1 = Math.min(cat1, cat2);
            this.cat2 = Math.max(cat1, cat2);
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Pair pair = (Pair) o;
            return cat1 == pair.cat1 && cat2 == pair.cat2;
        }

        @Override
        public int hashCode() {
            return Objects.hash(cat1, cat2);
        }
    }
}