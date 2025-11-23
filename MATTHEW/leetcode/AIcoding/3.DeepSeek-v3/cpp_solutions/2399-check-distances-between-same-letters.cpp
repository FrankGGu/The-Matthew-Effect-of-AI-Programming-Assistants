class Solution {
public:
    bool checkDistances(string s, vector<int>& distance) {
        vector<int> firstOccurrence(26, -1);
        for (int i = 0; i < s.size(); ++i) {
            int c = s[i] - 'a';
            if (firstOccurrence[c] == -1) {
                firstOccurrence[c] = i;
            } else {
                int expected = distance[c];
                int actual = i - firstOccurrence[c] - 1;
                if (actual != expected) {
                    return false;
                }
            }
        }
        return true;
    }
};