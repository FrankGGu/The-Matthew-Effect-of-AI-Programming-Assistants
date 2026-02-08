class Solution {
public:
    vector<vector<string>> groupAnagrams(vector<string>& strs) {
        std::unordered_map<std::string, std::vector<std::string>> anagramGroups;
        for (const std::string& str : strs) {
            std::string key = str;
            std::sort(key.begin(), key.end());
            anagramGroups[key].push_back(str);
        }

        std::vector<std::vector<std::string>> result;
        for (auto const& [key, val] : anagramGroups) {
            result.push_back(val);
        }
        return result;
    }
};