#include <vector>
#include <algorithm> // For std::sort

class Solution {
public:
    long long maximumPoints(std::vector<int>& enemyEnergies, long long currentEnergy) {
        std::sort(enemyEnergies.begin(), enemyEnergies.end());

        long long points = 0;
        int left = 0;
        int right = enemyEnergies.size() - 1;

        if (enemyEnergies.empty()) {
            return 0;
        }

        // If we cannot even battle the cheapest enemy initially, we cannot gain any points.
        // The only way to get points is by battling.
        if (currentEnergy < enemyEnergies[left]) {
            return 0;
        }

        // Perform the first battle to gain at least one point.
        // This is necessary to enable the "recruit" operation later if needed.
        currentEnergy -= enemyEnergies[left];
        points++;
        left++;

        while (left <= right) {
            if (currentEnergy >= enemyEnergies[left]) {
                // If we can battle the cheapest enemy, do it to gain a point.
                currentEnergy -= enemyEnergies[left];
                points++;
                left++;
            } else if (points > 0 && left < right) {
                // If we cannot battle the cheapest enemy, but have points,
                // recruit the most expensive enemy to increase currentEnergy.
                // We must have `left < right` to ensure we are recruiting a *different* enemy
                // to enable future battles, not just sacrificing a point for the same enemy
                // we're currently trying to battle.
                currentEnergy += enemyEnergies[right];
                points--;
                right--;
            } else {
                // Cannot battle the cheapest enemy, and either no points or only one enemy left.
                // No more productive moves.
                break;
            }
        }

        return points;
    }
};