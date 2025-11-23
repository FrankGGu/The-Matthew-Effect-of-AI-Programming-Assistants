#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    std::vector<int> peopleWhoseListIsNotASubset(std::vector<std::vector<std::string>>& favoriteCompanies) {
        int n = favoriteCompanies.size();
        std::vector<int> result;

        for (int i = 0; i < n; ++i) {
            bool isSubsetOfAnyOther = false;

            // Optimization: Sort favoriteCompanies[i] to potentially use std::includes later,
            // or just ensure consistent order if not using unordered_set.
            // For unordered_set, sorting is not strictly necessary for correctness,
            // but can be useful for debugging or if a different subset check method is chosen.
            // For this solution, we will stick with unordered_set for the superset for efficiency.
            // No need to sort the 'subset' list (favoriteCompanies[i]) either if using unordered_set for the superset.

            for (int j = 0; j < n; ++j) {
                if (i == j) {
                    continue;
                }

                // If favoriteCompanies[i] has more companies than favoriteCompanies[j],
                // it cannot be a subset of favoriteCompanies[j].
                if (favoriteCompanies[i].size() > favoriteCompanies[j].size()) {
                    continue;
                }

                // Check if favoriteCompanies[i] is a subset of favoriteCompanies[j]
                // Use an unordered_set for efficient lookups in favoriteCompanies[j].
                std::unordered_set<std::string> superSet(favoriteCompanies[j].begin(), favoriteCompanies[j].end());

                bool currentIsSubset = true;
                for (const std::string& company : favoriteCompanies[i]) {
                    if (superSet.find(company) == superSet.end()) {
                        currentIsSubset = false;
                        break;
                    }
                }

                if (currentIsSubset) {
                    isSubsetOfAnyOther = true;
                    break; // Found a superset, no need to check other j's for this i
                }
            }

            if (!isSubsetOfAnyOther) {
                result.push_back(i);
            }
        }

        return result;
    }
};