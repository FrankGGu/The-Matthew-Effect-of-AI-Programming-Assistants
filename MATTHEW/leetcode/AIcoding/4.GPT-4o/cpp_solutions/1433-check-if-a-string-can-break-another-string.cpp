class Solution {
public:
    bool checkIfCanBreak(string s1, string s2) {
        sort(s1.begin(), s1.end());
        sort(s2.begin(), s2.end());

        bool canBreak1 = true, canBreak2 = true;
        for (int i = 0; i < s1.size(); ++i) {
            if (s1[i] > s2[i]) canBreak2 = false;
            if (s1[i] < s2[i]) canBreak1 = false;
        }

        return canBreak1 || canBreak2;
    }
};