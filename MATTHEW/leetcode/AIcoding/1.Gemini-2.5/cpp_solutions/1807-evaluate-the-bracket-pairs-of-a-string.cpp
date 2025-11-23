#include <string>
#include <vector>
#include <unordered_map>

class Solution {
public:
    std::string evaluate(std::string s, std::vector<std::vector<std::string>>& knowledge) {
        std::unordered_map<std::string, std::string> knowledgeMap;
        for (const auto& pair : knowledge) {
            knowledgeMap[pair[0]] = pair[1];
        }

        std::string result = "";
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            if (s[i] == '(') {
                int j = i + 1;
                while (j < n && s[j] != ')') {
                    j++;
                }

                std::string key = s.substr(i + 1, j - (i + 1));

                auto it = knowledgeMap.find(key);
                if (it != knowledgeMap.end()) {
                    result += it->second;
                } else {
                    result += "?";
                }
                i = j; 
            } else {
                result += s[i];
            }
        }
        return result;
    }
};