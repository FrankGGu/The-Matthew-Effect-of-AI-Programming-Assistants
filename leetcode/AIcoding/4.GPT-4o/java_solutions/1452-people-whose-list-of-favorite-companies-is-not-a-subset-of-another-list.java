import java.util.*;

public class Solution {
    public List<String> peopleNotSubset(List<List<String>> favoriteCompanies) {
        Set<String> result = new HashSet<>();
        Map<String, Set<String>> companyMap = new HashMap<>();

        for (int i = 0; i < favoriteCompanies.size(); i++) {
            for (String company : favoriteCompanies.get(i)) {
                companyMap.putIfAbsent(company, new HashSet<>());
                companyMap.get(company).addAll(favoriteCompanies.get(i));
            }
        }

        for (int i = 0; i < favoriteCompanies.size(); i++) {
            Set<String> currentSet = new HashSet<>(favoriteCompanies.get(i));
            boolean isSubset = false;
            for (Set<String> companySet : companyMap.values()) {
                if (currentSet != companySet && companySet.containsAll(currentSet)) {
                    isSubset = true;
                    break;
                }
            }
            if (!isSubset) result.addAll(currentSet);
        }

        return new ArrayList<>(result);
    }
}