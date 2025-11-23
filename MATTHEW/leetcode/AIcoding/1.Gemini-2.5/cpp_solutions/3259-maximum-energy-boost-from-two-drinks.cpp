#include <vector>
#include <algorithm>
#include <set> // For std::multiset

class Solution {
public:
    long long maximumEnergyBoost(std::vector<std::vector<int>>& drinks, int k) {
        std::vector<std::pair<int, int>> sorted_drinks;
        for (const auto& drink : drinks) {
            sorted_drinks.push_back({drink[1], drink[0]}); // Store as {cost, energy}
        }

        std::sort(sorted_drinks.begin(), sorted_drinks.end());

        long long max_energy_boost = -1;
        std::multiset<int> energies_available;
        int left = 0;

        for (int right = 0; right < sorted_drinks.size(); ++right) {
            int current_cost = sorted_drinks[right].first;
            int current_energy = sorted_drinks[right].second;

            while (left < right && sorted_drinks[left].first + current_cost > k) {
                energies_available.erase(energies_available.find(sorted_drinks[left].second));
                left++;
            }

            if (!energies_available.empty()) {
                max_energy_boost = std::max(max_energy_boost, (long long)current_energy + *energies_available.rbegin());
            }

            energies_available.insert(current_energy);
        }

        return max_energy_boost;
    }
};