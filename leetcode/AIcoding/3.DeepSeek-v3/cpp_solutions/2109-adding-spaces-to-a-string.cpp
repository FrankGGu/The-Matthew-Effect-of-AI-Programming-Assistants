class Solution {
public:
    string addSpaces(string s, vector<int>& spaces) {
        string result;
        int spacePtr = 0;
        for (int i = 0; i < s.size(); ++i) {
            if (spacePtr < spaces.size() && i == spaces[spacePtr]) {
                result += ' ';
                spacePtr++;
            }
            result += s[i];
        }
        return result;
    }
};