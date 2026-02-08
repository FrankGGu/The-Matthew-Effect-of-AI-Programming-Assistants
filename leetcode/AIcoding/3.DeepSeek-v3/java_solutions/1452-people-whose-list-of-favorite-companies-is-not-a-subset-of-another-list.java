class Solution {
    public List<Integer> peopleIndexes(List<List<String>> favoriteCompanies) {
        List<Integer> result = new ArrayList<>();
        int n = favoriteCompanies.size();
        for (int i = 0; i < n; i++) {
            boolean isSubset = false;
            for (int j = 0; j < n; j++) {
                if (i == j) continue;
                if (favoriteCompanies.get(j).containsAll(favoriteCompanies.get(i))) {
                    isSubset = true;
                    break;
                }
            }
            if (!isSubset) {
                result.add(i);
            }
        }
        return result;
    }
}