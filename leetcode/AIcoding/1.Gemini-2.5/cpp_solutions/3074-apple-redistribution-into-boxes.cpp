#include <numeric>
#include <vector>

class Solution {
public:
    long long redistributeApples(std::vector<int>& boxTypes, int maxBoxes) {
        std::sort(boxTypes.begin(), boxTypes.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[1] > b[1];
        });

        long long totalApples = 0;
        int boxesUsed = 0;

        for (const auto& boxType : boxTypes) {
            int numBoxes = boxType[0];
            int applesPerBox = boxType[1];

            int boxesToUse = std::min(numBoxes, maxBoxes - boxesUsed);

            totalApples += (long long)boxesToUse * applesPerBox;
            boxesUsed += boxesToUse;

            if (boxesUsed == maxBoxes) {
                break;
            }
        }

        return totalApples;
    }
};