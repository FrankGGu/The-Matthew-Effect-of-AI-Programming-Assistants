import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public List<Integer> peopleWhoseListOfFavoriteCompaniesIsNotASubsetOfAnotherList(List<List<String>> favoriteCompanies) {
        int n = favoriteCompanies.size();
        List<Set<String>> favoriteSets = new ArrayList<>();
        for (List<String> companies : favoriteCompanies) {
            favoriteSets.add(new HashSet<>(companies));
        }

        List<Integer> result = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            boolean isSubsetOfAnother = false;
            Set<String> currentPersonSet = favoriteSets.get(i);

            for (int j = 0; j < n; j++) {
                if (i == j) {
                    continue;
                }

                Set<String> otherPersonSet = favoriteSets.get(j);

                // Optimization: if current set is larger, it cannot be a subset of the other set
                if (currentPersonSet.size() > otherPersonSet.size()) {
                    continue;
                }

                boolean currentIsSubsetOfOther = true;
                for (String company : currentPersonSet) {
                    if (!otherPersonSet.contains(company)) {
                        currentIsSubsetOfOther = false;
                        break;
                    }
                }

                if (currentIsSubsetOfOther) {
                    isSubsetOfAnother = true;
                    break; 
                }
            }

            if (!isSubsetOfAnother) {
                result.add(i);
            }
        }

        return result;
    }
}