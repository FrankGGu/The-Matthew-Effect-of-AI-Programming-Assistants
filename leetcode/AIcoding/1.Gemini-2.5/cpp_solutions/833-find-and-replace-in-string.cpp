#include <string>
#include <vector>
#include <map>
#include <utility>

class Solution {
public:
    std::string findReplaceString(std::string s, std::vector<int>& indices, std::vector<std::string>& sources, std::vector<std::string>& targets) {
        std::map<int, std::pair<std::string, std::string>> replacements;

        for (int k = 0; k < indices.size(); ++k) {
            int idx = indices[k];
            const std::string& source = sources[k];
            const std::string& target = targets[k];

            if (idx + source.length() <= s.length() && s.compare(idx, source.length(), source) == 0) {
                replacements[idx] = {source, target};
            }
        }

        std::string result = "";
        int i = 0;
        while (i < s.length()) {
            if (replacements.count(i)) {
                auto p = replacements[i];
                result += p.second;
                i += p.first.length();
            } else {
                result += s[i];
                i++;
            }
        }

        return result;
    }
};