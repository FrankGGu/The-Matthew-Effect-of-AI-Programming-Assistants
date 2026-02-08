#include <vector>

class Solution {
public:
    int minimumRefills(std::vector<int>& plants, int capacityA, int capacityB) {
        int refills = 0;
        int currentWaterA = capacityA;
        int currentWaterB = capacityB;
        int left = 0;
        int right = plants.size() - 1;

        while (left <= right) {
            if (left == right) {
                if (currentWaterA >= currentWaterB) {
                    if (currentWaterA < plants[left]) {
                        refills++;
                    }
                } else {
                    if (currentWaterB < plants[right]) {
                        refills++;
                    }
                }
                break;
            }

            if (currentWaterA < plants[left]) {
                refills++;
                currentWaterA = capacityA;
            }
            currentWaterA -= plants[left];
            left++;

            if (currentWaterB < plants[right]) {
                refills++;
                currentWaterB = capacityB;
            }
            currentWaterB -= plants[right];
            right--;
        }

        return refills;
    }
};