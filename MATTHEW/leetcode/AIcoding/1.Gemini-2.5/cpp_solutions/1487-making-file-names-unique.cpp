#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    std::vector<std::string> getFolderNames(std::vector<std::string>& names) {
        std::unordered_map<std::string, int> next_k;
        std::vector<std::string> result;
        result.reserve(names.size());

        for (const std::string& name : names) {
            if (next_k.find(name) == next_k.end()) {
                result.push_back(name);
                next_k[name] = 1;
            } else {
                int k = next_k[name];
                std::string new_name = name + "(" + std::to_string(k) + ")";
                while (next_k.find(new_name) != next_k.end()) {
                    k++;
                    new_name = name + "(" + std::to_string(k) + ")";
                }
                result.push_back(new_name);
                next_k[name] = k + 1;
                next_k[new_name] = 1;
            }
        }
        return result;
    }
};