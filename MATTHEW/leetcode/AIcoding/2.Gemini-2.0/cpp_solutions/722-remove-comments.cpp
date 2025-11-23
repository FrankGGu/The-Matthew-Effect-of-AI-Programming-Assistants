#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    vector<string> removeComments(vector<string>& source) {
        vector<string> result;
        bool inBlockComment = false;
        string currentLine = "";

        for (string& line : source) {
            for (int i = 0; i < line.length(); ++i) {
                if (inBlockComment) {
                    if (line[i] == '*' && i + 1 < line.length() && line[i + 1] == '/') {
                        inBlockComment = false;
                        i++; 
                    }
                } else {
                    if (line[i] == '/' && i + 1 < line.length() && line[i + 1] == '/') {
                        break;
                    } else if (line[i] == '/' && i + 1 < line.length() && line[i + 1] == '*') {
                        inBlockComment = true;
                        i++;
                    } else {
                        currentLine += line[i];
                    }
                }
            }
            if (!inBlockComment && !currentLine.empty()) {
                result.push_back(currentLine);
                currentLine = "";
            } else if (!inBlockComment && currentLine.empty() && result.empty() && source.size() == 1 && source[0].find("/*") == string::npos && source[0].find("//") == string::npos) {
                result.push_back("");
            } else if (!inBlockComment && currentLine.empty() && result.empty() && source.size() == 1 && (source[0].find("/*") != string::npos || source[0].find("//") != string::npos) && source[0].length() > 0 &&  source[0][0] == '/' ) {

            }

        }

        return result;
    }
};