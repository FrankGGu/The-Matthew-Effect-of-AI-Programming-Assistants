class Solution {
public:
    vector<string> successfulPairs(vector<string>& names, vector<int>& values) {
        int n = names.size();
        vector<string> result;
        unordered_map<string, int> freq;
        for (const auto& name : names) {
            freq[name]++;
        }

        for (const auto& [name, count] : freq) {
            result.push_back(name + " " + to_string(count));
        }

        sort(result.begin(), result.end());
        return result;
    }
};