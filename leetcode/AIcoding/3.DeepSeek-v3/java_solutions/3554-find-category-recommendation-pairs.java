import java.util.*;

class Solution {
    public List<List<String>> findCategoryRecommendationPairs(String[] userPurchases, String[][] categoryPairs) {
        Map<String, Set<String>> userToCategories = new HashMap<>();
        Map<String, Set<String>> categoryToUsers = new HashMap<>();

        for (String purchase : userPurchases) {
            String[] parts = purchase.split(":");
            String user = parts[0];
            String category = parts[1];

            userToCategories.computeIfAbsent(user, k -> new HashSet<>()).add(category);
            categoryToUsers.computeIfAbsent(category, k -> new HashSet<>()).add(user);
        }

        Set<List<String>> resultSet = new HashSet<>();

        for (String[] pair : categoryPairs) {
            String cat1 = pair[0];
            String cat2 = pair[1];

            Set<String> users1 = categoryToUsers.getOrDefault(cat1, Collections.emptySet());
            Set<String> users2 = categoryToUsers.getOrDefault(cat2, Collections.emptySet());

            Set<String> commonUsers = new HashSet<>(users1);
            commonUsers.retainAll(users2);

            for (String user : commonUsers) {
                Set<String> userCats = userToCategories.get(user);
                if (userCats.contains(cat1) && userCats.contains(cat2)) {
                    continue;
                }

                List<String> sortedPair = new ArrayList<>();
                sortedPair.add(cat1);
                sortedPair.add(cat2);
                Collections.sort(sortedPair);
                resultSet.add(sortedPair);
            }
        }

        List<List<String>> result = new ArrayList<>(resultSet);
        Collections.sort(result, (a, b) -> {
            if (a.get(0).equals(b.get(0))) {
                return a.get(1).compareTo(b.get(1));
            } else {
                return a.get(0).compareTo(b.get(0));
            }
        });

        return result;
    }
}