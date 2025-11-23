class Solution {
public:
    string minimumString(string a, string b, string c) {
        vector<string> candidates;
        candidates.push_back(merge(merge(a, b), c));
        candidates.push_back(merge(merge(a, c), b));
        candidates.push_back(merge(merge(b, a), c));
        candidates.push_back(merge(merge(b, c), a));
        candidates.push_back(merge(merge(c, a), b));
        candidates.push_back(merge(merge(c, b), a));

        sort(candidates.begin(), candidates.end(), [](const string& s1, const string& s2) {
            if (s1.size() == s2.size()) {
                return s1 < s2;
            }
            return s1.size() < s2.size();
        });

        return candidates[0];
    }

private:
    string merge(const string& a, const string& b) {
        if (a.find(b) != string::npos) return a;
        if (b.find(a) != string::npos) return b;

        int max_overlap = min(a.size(), b.size());
        while (max_overlap > 0) {
            if (a.substr(a.size() - max_overlap) == b.substr(0, max_overlap)) {
                return a + b.substr(max_overlap);
            }
            max_overlap--;
        }
        return a + b;
    }
};