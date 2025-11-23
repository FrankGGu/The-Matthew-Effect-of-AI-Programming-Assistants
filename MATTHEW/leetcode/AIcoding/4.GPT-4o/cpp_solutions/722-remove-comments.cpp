class Solution {
public:
    vector<string> removeComments(vector<string>& source) {
        vector<string> result;
        string currentLine;
        bool inBlockComment = false;

        for (const string& line : source) {
            for (size_t i = 0; i < line.size(); ++i) {
                if (inBlockComment) {
                    if (i + 1 < line.size() && line[i] == '*' && line[i + 1] == '/') {
                        inBlockComment = false;
                        i++; // Skip the '/' character
                    }
                } else {
                    if (i + 1 < line.size() && line[i] == '/' && line[i + 1] == '*') {
                        inBlockComment = true;
                        i++; // Skip the '*' character
                    } else if (i + 1 < line.size() && line[i] == '/' && line[i + 1] == '/') {
                        break; // End of line comment
                    } else {
                        currentLine += line[i];
                    }
                }
            }
            if (!inBlockComment && !currentLine.empty()) {
                result.push_back(currentLine);
                currentLine.clear();
            }
        }
        return result;
    }
};