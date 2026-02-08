#include <vector>
#include <algorithm>
#include <functional>

class Solution {
public:
    long long minimumCost(int m, int n, std::vector<int>& horizontalCut, std::vector<int>& verticalCut) {
        std::sort(horizontalCut.rbegin(), horizontalCut.rend());
        std::sort(verticalCut.rbegin(), verticalCut.rend());

        long long totalCost = 0;
        long long horizontalPieces = 1;
        long long verticalPieces = 1;

        int i = 0;
        int j = 0;

        while (i < horizontalCut.size() || j < verticalCut.size()) {
            if (j >= verticalCut.size() || (i < horizontalCut.size() && horizontalCut[i] > verticalCut[j])) {
                totalCost += (long long)horizontalCut[i] * verticalPieces;
                horizontalPieces++;
                i++;
            } else {
                totalCost += (long long)verticalCut[j] * horizontalPieces;
                verticalPieces++;
                j++;
            }
        }

        return totalCost;
    }
};