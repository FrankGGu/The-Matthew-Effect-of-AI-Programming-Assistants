class Solution {
public:
    bool isRationalEqual(string s, string t) {
        return f(s) == f(t);
    }

private:
    double f(const string& s) {
        auto i = s.find('(');
        if (i != string::npos) {
            string base = s.substr(0, i);
            string rep = s.substr(i + 1, s.size() - i - 2);
            for (int j = 0; j < 20; ++j) base += rep;
            return stod(base);
        }
        return stod(s);
    }
};