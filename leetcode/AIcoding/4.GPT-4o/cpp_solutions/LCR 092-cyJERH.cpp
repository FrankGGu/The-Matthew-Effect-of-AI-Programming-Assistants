class Solution {
public:
    string makeSmallestSpecial(string s) {
        int count = 0;
        vector<string> special;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '1') count++;
            else count--;
            if (count == 0) {
                special.push_back("1" + makeSmallestSpecial(s.substr(1, i - 1)) + "0");
            }
        }
        sort(special.begin(), special.end());
        return accumulate(special.begin(), special.end(), string());
    }
};