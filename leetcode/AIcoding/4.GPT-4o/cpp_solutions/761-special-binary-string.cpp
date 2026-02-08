class Solution {
public:
    string makeLargestSpecial(string s) {
        vector<string> specials;
        int count = 0, last = 0;

        for (int i = 0; i < s.size(); ++i) {
            count += (s[i] == '1') ? 1 : -1;
            if (count == 0) {
                specials.push_back("1" + makeLargestSpecial(s.substr(last + 1, i - last)) + "0");
                last = i + 1;
            }
        }

        sort(specials.rbegin(), specials.rend());
        return accumulate(specials.begin(), specials.end(), string());
    }
};