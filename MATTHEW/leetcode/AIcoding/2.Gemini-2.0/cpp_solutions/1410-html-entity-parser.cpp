#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string entityParser(string text) {
        unordered_map<string, string> entities = {
            {"&quot;", "\""},
            {"&apos;", "'"},
            {"&amp;", "&"},
            {"&gt;", ">"},
            {"&lt;", "<"},
            {"&frasl;", "/"}
        };

        string result = "";
        for (int i = 0; i < text.length(); ++i) {
            if (text[i] == '&') {
                bool found = false;
                for (auto const& [key, val] : entities) {
                    if (i + key.length() <= text.length() && text.substr(i, key.length()) == key) {
                        result += val;
                        i += key.length() - 1;
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    result += text[i];
                }
            } else {
                result += text[i];
            }
        }

        return result;
    }
};