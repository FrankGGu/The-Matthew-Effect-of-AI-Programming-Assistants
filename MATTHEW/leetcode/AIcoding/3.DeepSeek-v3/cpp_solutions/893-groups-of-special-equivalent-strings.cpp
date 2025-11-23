class Solution {
public:
    int numSpecialEquivGroups(vector<string>& words) {
        unordered_set<string> groups;
        for (const string& word : words) {
            string odd, even;
            for (int i = 0; i < word.size(); ++i) {
                if (i % 2 == 0) {
                    even += word[i];
                } else {
                    odd += word[i];
                }
            }
            sort(odd.begin(), odd.end());
            sort(even.begin(), even.end());
            groups.insert(odd + even);
        }
        return groups.size();
    }
};