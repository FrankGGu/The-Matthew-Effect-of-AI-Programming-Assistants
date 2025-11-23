#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string entityParser(string text) {
        unordered_map<string, string> entityMap = {
            {"&quot;", "\""},
            {"&apos;", "'"},
            {"&amp;", "&"},
            {"&gt;", ">"}, 
            {"&lt;", "<"},
            {"&frasl;", "/"}
        };

        string result;
        int i = 0;
        while (i < text.size()) {
            if (text[i] == '&' && i + 1 < text.size()) {
                bool found = false;
                for (const auto& pair : entityMap) {
                    const string& key = pair.first;
                    if (text.substr(i, key.size()) == key) {
                        result += pair.second;
                        i += key.size();
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    result += text[i];
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