class Solution {
public:
    vector<string> ambiguousCoordinates(string s) {
        vector<string> res;
        string num = s.substr(1, s.size() - 2);
        for (int i = 1; i < num.size(); ++i) {
            string left = num.substr(0, i);
            string right = num.substr(i);
            vector<string> leftNums = generateNumbers(left);
            vector<string> rightNums = generateNumbers(right);
            for (const string& l : leftNums) {
                for (const string& r : rightNums) {
                    res.push_back("(" + l + ", " + r + ")");
                }
            }
        }
        return res;
    }

private:
    vector<string> generateNumbers(string s) {
        vector<string> res;
        if (s.size() == 1) {
            res.push_back(s);
            return res;
        }
        if (s[0] == '0') {
            if (s.back() == '0') return res;
            res.push_back("0." + s.substr(1));
            return res;
        }
        if (s.back() == '0') {
            res.push_back(s);
            return res;
        }
        res.push_back(s);
        for (int i = 1; i < s.size(); ++i) {
            res.push_back(s.substr(0, i) + "." + s.substr(i));
        }
        return res;
    }
};