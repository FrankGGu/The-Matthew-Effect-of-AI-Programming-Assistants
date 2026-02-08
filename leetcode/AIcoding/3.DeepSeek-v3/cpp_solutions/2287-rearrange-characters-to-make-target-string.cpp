class Solution {
public:
    int rearrangeCharacters(string s, string target) {
        unordered_map<char, int> sCount, targetCount;
        for (char c : s) {
            sCount[c]++;
        }
        for (char c : target) {
            targetCount[c]++;
        }
        int result = INT_MAX;
        for (auto& [c, cnt] : targetCount) {
            if (sCount[c] < cnt) {
                return 0;
            }
            result = min(result, sCount[c] / cnt);
        }
        return result;
    }
};