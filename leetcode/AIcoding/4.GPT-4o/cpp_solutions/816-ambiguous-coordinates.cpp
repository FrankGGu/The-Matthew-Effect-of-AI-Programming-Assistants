class Solution {
public:
    vector<string> ambiguousCoordinates(string s) {
        s = s.substr(1, s.size() - 2);
        vector<string> result;
        for (int i = 1; i < s.size(); ++i) {
            string x = s.substr(0, i);
            string y = s.substr(i);
            vector<string> x_coords = getCoordinates(x);
            vector<string> y_coords = getCoordinates(y);
            for (const string& a : x_coords) {
                for (const string& b : y_coords) {
                    result.push_back("(" + a + ", " + b + ")");
                }
            }
        }
        return result;
    }

private:
    vector<string> getCoordinates(const string& s) {
        vector<string> coords;
        int n = s.size();
        if (n == 0) return coords;
        if (n == 1 || (s[0] != '0')) {
            coords.push_back(s);
        }
        for (int i = 1; i < n; ++i) {
            string left = s.substr(0, i);
            string right = s.substr(i);
            if ((left[0] != '0' || left.size() == 1) && (right.empty() || right.back() != '0')) {
                coords.push_back(left + "." + right);
            }
        }
        return coords;
    }
};