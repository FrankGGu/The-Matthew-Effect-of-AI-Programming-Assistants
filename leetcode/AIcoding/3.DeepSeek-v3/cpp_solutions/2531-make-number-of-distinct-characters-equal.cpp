class Solution {
public:
    bool isItPossible(string word1, string word2) {
        unordered_map<char, int> freq1, freq2;
        for (char c : word1) freq1[c]++;
        for (char c : word2) freq2[c]++;

        for (auto [c1, cnt1] : freq1) {
            for (auto [c2, cnt2] : freq2) {
                unordered_map<char, int> temp1 = freq1;
                unordered_map<char, int> temp2 = freq2;

                temp1[c1]--;
                if (temp1[c1] == 0) temp1.erase(c1);
                temp1[c2]++;

                temp2[c2]--;
                if (temp2[c2] == 0) temp2.erase(c2);
                temp2[c1]++;

                if (temp1.size() == temp2.size()) {
                    return true;
                }
            }
        }
        return false;
    }
};