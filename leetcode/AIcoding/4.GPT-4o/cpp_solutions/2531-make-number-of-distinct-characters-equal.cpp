class Solution {
public:
    bool isPossible(string s, string t) {
        vector<int> countS(26, 0), countT(26, 0);
        for (char c : s) countS[c - 'a']++;
        for (char c : t) countT[c - 'a']++;

        int distinctS = count_if(countS.begin(), countS.end(), [](int x) { return x > 0; });
        int distinctT = count_if(countT.begin(), countT.end(), [](int x) { return x > 0; });

        return distinctS == distinctT;
    }
};