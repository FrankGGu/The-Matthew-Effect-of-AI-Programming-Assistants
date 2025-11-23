#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumContainers(std::vector<std::vector<int>>& containers, int shipCapacity) {
        std::sort(containers.begin(), containers.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[1] > b[1];
        });

        long long totalItems = 0;
        for (const auto& containerType : containers) {
            int numberOfContainers = containerType[0];
            int itemsPerContainer = containerType[1];

            if (shipCapacity == 0) {
                break;
            }

            int containersToLoad = std::min(numberOfContainers, shipCapacity);
            totalItems += (long long)containersToLoad * itemsPerContainer;
            shipCapacity -= containersToLoad;
        }

        return totalItems;
    }
};