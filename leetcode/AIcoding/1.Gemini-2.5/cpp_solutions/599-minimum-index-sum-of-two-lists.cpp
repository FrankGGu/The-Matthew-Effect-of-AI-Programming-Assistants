#include <vector>
#include <string>
#include <unordered_map>
#include <limits>

class Solution {
public:
    std::vector<std::string> findRestaurant(std::vector<std::string>& list1, std::vector<std::string>& list2) {
        std::unordered_map<std::string, int> map1;
        for (int i = 0; i < list1.size(); ++i) {
            map1[list1[i]] = i;
        }

        std::vector<std::string> result;
        int min_sum = std::numeric_limits<int>::max();

        for (int j = 0; j < list2.size(); ++j) {
            if (map1.count(list2[j])) {
                int current_sum = j + map1[list2[j]];
                if (current_sum < min_sum) {
                    min_sum = current_sum;
                    result.clear();
                    result.push_back(list2[j]);
                } else if (current_sum == min_sum) {
                    result.push_back(list2[j]);
                }
            }
        }

        return result;
    }
};