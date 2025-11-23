#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> removeComments(std::vector<std::string>& source) {
        std::vector<std::string> result;
        std::string currentLineBuffer;
        bool inBlockComment = false;

        for (const std::string& line : source) {
            for (int i = 0; i < line.length(); ++i) {
                if (inBlockComment) {
                    if (i + 1 < line.length() && line[i] == '*' && line[i+1] == '/') {
                        inBlockComment = false;
                        i++; 
                    }
                } else {
                    if (i + 1 < line.length() && line[i] == '/' && line[i+1] == '*') {
                        inBlockComment = true;
                        i++; 
                    } else if (i + 1 < line.length() && line[i] == '/' && line[i+1] == '/') {
                        break; 
                    } else {
                        currentLineBuffer += line[i];
                    }
                }
            }

            if (!inBlockComment) {
                if (!currentLineBuffer.empty()) {
                    result.push_back(currentLineBuffer);
                    currentLineBuffer.clear();
                }
            }
        }

        return result;
    }
};