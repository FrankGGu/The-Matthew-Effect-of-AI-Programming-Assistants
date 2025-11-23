public class Solution {

import java.util.*;

public class Solution {
    public List<String> peopleIndexes(List<List<String>> favoriteCompanies) {
        Map<String, Integer> companyToIndex = new HashMap<>();
        int index = 0;
        for (List<String> companies : favoriteCompanies) {
            for (String company : companies) {
                if (!companyToIndex.containsKey(company)) {
                    companyToIndex.put(company, index++);
                }
            }
        }

        int n = favoriteCompanies.size();
        Set<Integer>[] companySets = new HashSet[n];
        for (int i = 0; i < n; i++) {
            companySets[i] = new HashSet<>();
            for (String company : favoriteCompanies.get(i)) {
                companySets[i].add(companyToIndex.get(company));
            }
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            boolean isNotSubset = true;
            for (int j = 0; j < n; j++) {
                if (i != j && isSubset(companySets[i], companySets[j])) {
                    isNotSubset = false;
                    break;
                }
            }
            if (isNotSubset) {
                result.add(i);
            }
        }

        Collections.sort(result);
        List<String> output = new ArrayList<>();
        for (int i : result) {
            output.add(String.valueOf(i));
        }
        return output;
    }

    private boolean isSubset(Set<Integer> a, Set<Integer> b) {
        if (a.size() > b.size()) {
            return false;
        }
        for (int num : a) {
            if (!b.contains(num)) {
                return false;
            }
        }
        return true;
    }
}
}