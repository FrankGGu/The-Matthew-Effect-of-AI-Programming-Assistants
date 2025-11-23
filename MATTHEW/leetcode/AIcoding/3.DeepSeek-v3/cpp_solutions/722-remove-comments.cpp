class Solution {
public:
    vector<string> removeComments(vector<string>& source) {
        vector<string> res;
        bool inBlock = false;
        string out;
        for (string line : source) {
            for (int i = 0; i < line.size(); ++i) {
                if (!inBlock) {
                    if (i + 1 < line.size() && line[i] == '/' && line[i+1] == '*') {
                        inBlock = true;
                        ++i;
                    } else if (i + 1 < line.size() && line[i] == '/' && line[i+1] == '/') {
                        break;
                    } else {
                        out.push_back(line[i]);
                    }
                } else {
                    if (i + 1 < line.size() && line[i] == '*' && line[i+1] == '/') {
                        inBlock = false;
                        ++i;
                    }
                }
            }
            if (!inBlock && !out.empty()) {
                res.push_back(out);
                out.clear();
            }
        }
        return res;
    }
};