class Solution {
public:
    int lengthLongestPath(string input) {
        unordered_map<int, int> pathLength;
        int maxLength = 0;
        istringstream iss(input);
        string line;

        while (getline(iss, line)) {
            int level = 0;
            while (level < line.length() && line[level] == '\t') {
                level++;
            }
            int currentLength = line.length() - level;
            if (level > 0) {
                currentLength += pathLength[level - 1] + 1;
            }
            pathLength[level] = currentLength;
            if (line.find('.') != string::npos) {
                maxLength = max(maxLength, currentLength);
            }
        }

        return maxLength;
    }
};