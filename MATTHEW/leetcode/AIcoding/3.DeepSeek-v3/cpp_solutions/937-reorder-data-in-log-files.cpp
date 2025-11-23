class Solution {
public:
    vector<string> reorderLogFiles(vector<string>& logs) {
        vector<string> letterLogs, digitLogs;
        for (const string& log : logs) {
            int i = log.find(' ');
            if (isalpha(log[i + 1])) {
                letterLogs.push_back(log);
            } else {
                digitLogs.push_back(log);
            }
        }

        auto cmp = [](const string& a, const string& b) {
            int i = a.find(' ');
            int j = b.find(' ');
            string contentA = a.substr(i + 1);
            string contentB = b.substr(j + 1);
            if (contentA != contentB) {
                return contentA < contentB;
            } else {
                return a.substr(0, i) < b.substr(0, j);
            }
        };

        sort(letterLogs.begin(), letterLogs.end(), cmp);
        letterLogs.insert(letterLogs.end(), digitLogs.begin(), digitLogs.end());
        return letterLogs;
    }
};