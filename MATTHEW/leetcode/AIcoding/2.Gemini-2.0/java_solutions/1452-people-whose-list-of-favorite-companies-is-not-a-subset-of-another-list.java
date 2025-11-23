import java.util.*;

class Solution {
    public List<Integer> peopleWhoseListOfFavoriteCompaniesIsNotASubsetOfAnotherList(List<List<String>> favoriteCompanies) {
        int n = favoriteCompanies.size();
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            boolean isSubset = false;
            for (int j = 0; j < n; j++) {
                if (i != j && isSubset(favoriteCompanies.get(i), favoriteCompanies.get(j))) {
                    isSubset = true;
                    break;
                }
            }
            if (!isSubset) {
                result.add(i);
            }
        }
        Collections.sort(result);
        return result;
    }

    private boolean isSubset(List<String> list1, List<String> list2) {
        if (list1.size() > list2.size()) {
            return false;
        }
        Set<String> set2 = new HashSet<>(list2);
        for (String company : list1) {
            if (!set2.contains(company)) {
                return false;
            }
        }
        return true;
    }
}