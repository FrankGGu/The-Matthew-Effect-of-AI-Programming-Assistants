#include <string>
#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    std::string findMostCommonResponse(std::vector<std::string>& responses) {
        std::map<std::string, int> counts;
        for (const std::string& response : responses) {
            counts[response]++;
        }

        std::string most_common_response = "";
        int max_freq = 0;

        for (const auto& pair : counts) {
            if (pair.second > max_freq) {
                max_freq = pair.second;
                most_common_response = pair.first;
            }
        }

        return most_common_response;
    }
};