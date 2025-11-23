class Solution {
public:
    vector<string> braceExpansionII(string expression) {
        set<string> result;
        parseExpression(expression, 0, expression.size(), result);
        return vector<string>(result.begin(), result.end());
    }

    void parseExpression(const string& expr, int start, int end, set<string>& result) {
        vector<string> parts;
        int i = start;
        while (i < end) {
            if (expr[i] == '{') {
                int j = i + 1, braceCount = 1;
                while (j < end && braceCount > 0) {
                    if (expr[j] == '{') braceCount++;
                    if (expr[j] == '}') braceCount--;
                    j++;
                }
                vector<string> subResults;
                parseExpression(expr, i + 1, j - 1, subResults);
                parts.push_back(subResults);
                i = j;
            } else {
                int j = i;
                while (j < end && expr[j] != '{' && expr[j] != '}') j++;
                parts.push_back(expr.substr(i, j - i));
                i = j;
            }
        }
        combineParts(parts, result);
    }

    void combineParts(vector<string>& parts, set<string>& result) {
        if (parts.empty()) return;
        set<string> currentResults;
        for (const string& part : parts) {
            if (part.empty()) continue;
            if (part[0] == '{') {
                vector<string> subParts;
                stringstream ss(part.substr(1, part.size() - 2));
                string token;
                while (getline(ss, token, ',')) {
                    subParts.push_back(token);
                }
                if (currentResults.empty()) {
                    currentResults.insert(subParts.begin(), subParts.end());
                } else {
                    set<string> newResults;
                    for (const string& str : currentResults) {
                        for (const string& sub : subParts) {
                            newResults.insert(str + sub);
                        }
                    }
                    currentResults = newResults;
                }
            } else {
                if (currentResults.empty()) {
                    currentResults.insert(part);
                } else {
                    set<string> newResults;
                    for (const string& str : currentResults) {
                        newResults.insert(str + part);
                    }
                    currentResults = newResults;
                }
            }
        }
        result.insert(currentResults.begin(), currentResults.end());
    }
};