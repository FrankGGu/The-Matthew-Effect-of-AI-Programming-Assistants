#include <string>
#include <vector>
#include <algorithm>

struct Entity {
    std::string entity;
    std::string character;

    bool operator<(const Entity& other) const {
        return entity.length() > other.entity.length();
    }
};

class Solution {
public:
    std::string entityParser(std::string text) {
        std::vector<Entity> replacements = {
            {"&frasl;", "/"},
            {"&quot;", "\""},
            {"&apos;", "'"},
            {"&amp;", "&"},
            {"&gt;", ">"},
            {"&lt;", "<"}
        };

        std::sort(replacements.begin(), replacements.end());

        std::string result = "";
        int n = text.length();
        int i = 0;
        while (i < n) {
            if (text[i] == '&') {
                bool replaced = false;
                for (const auto& rep : replacements) {
                    if (i + rep.entity.length() <= n && text.substr(i, rep.entity.length()) == rep.entity) {
                        result += rep.character;
                        i += rep.entity.length();
                        replaced = true;
                        break;
                    }
                }
                if (!replaced) {
                    result += '&';
                    i++;
                }
            } else {
                result += text[i];
                i++;
            }
        }
        return result;
    }
};