class Solution {
public:
    vector<string> removeAnagrams(vector<string>& words) {
        vector<string> result;
        string prev = "";
        for (const string& word : words) {
            string current = word;
            sort(current.begin(), current.end());
            if (current != prev) {
                result.push_back(word);
                prev = current;
            }
        }
        return result;
    }
};