class Solution {
public:
    string entityParser(string text) {
        unordered_map<string, char> entities = {
            {"&quot;", '"'},
            {"&apos;", '\''},
            {"&amp;", '&'},
            {"&gt;", '>'},
            {"&lt;", '<'},
            {"&frasl;", '/'}
        };

        string result;
        int i = 0;
        int n = text.size();

        while (i < n) {
            if (text[i] == '&') {
                bool found = false;
                for (const auto& pair : entities) {
                    const string& entity = pair.first;
                    if (i + entity.size() <= n && text.substr(i, entity.size()) == entity) {
                        result += pair.second;
                        i += entity.size();
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