class Solution {
public:
    vector<string> getFolderNames(vector<string>& names) {
        unordered_map<string, int> count;
        vector<string> result;

        for (const string& name : names) {
            string currentName = name;
            if (count[currentName]++ > 0) {
                while (count[currentName] > 0) {
                    currentName = name + "(" + to_string(count[name]) + ")";
                    count[name]++;
                }
                count[currentName]++;
            }
            result.push_back(currentName);
        }

        return result;
    }
};