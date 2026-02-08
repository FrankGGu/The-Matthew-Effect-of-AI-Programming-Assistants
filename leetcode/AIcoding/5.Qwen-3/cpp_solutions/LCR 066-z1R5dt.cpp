#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    std::vector<int> mapSum(std::vector<std::string>& keys, std::vector<int>& vals) {
        std::unordered_map<std::string, int> map;
        std::vector<int> result;
        for (int i = 0; i < keys.size(); ++i) {
            std::string key = keys[i];
            int val = vals[i];
            if (map.find(key) != map.end()) {
                map[key] = val;
            } else {
                map[key] = val;
            }
            int sum = 0;
            for (const auto& pair : map) {
                if (pair.first.find(key) == 0) {
                    sum += pair.second;
                }
            }
            result.push_back(sum);
        }
        return result;
    }
};