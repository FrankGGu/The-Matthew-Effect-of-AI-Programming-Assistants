class Solution {
public:
    vector<string> getFolderNames(vector<string>& names) {
        unordered_map<string, int> nameCount;
        vector<string> result;

        for (const string& name : names) {
            if (nameCount.find(name) == nameCount.end()) {
                nameCount[name] = 1;
                result.push_back(name);
            } else {
                int k = nameCount[name];
                string newName;
                do {
                    newName = name + "(" + to_string(k) + ")";
                    k++;
                } while (nameCount.find(newName) != nameCount.end());

                nameCount[name] = k;
                nameCount[newName] = 1;
                result.push_back(newName);
            }
        }

        return result;
    }
};