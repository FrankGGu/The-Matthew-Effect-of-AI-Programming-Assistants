class Solution {
public:
    bool canConvert(string str1, string str2) {
        if (str1 == str2) return true;
        unordered_map<char, char> conversionMap;
        unordered_set<char> uniqueCharsInStr2;

        for (int i = 0; i < str1.size(); ++i) {
            char c1 = str1[i];
            char c2 = str2[i];

            if (conversionMap.find(c1) != conversionMap.end()) {
                if (conversionMap[c1] != c2) {
                    return false;
                }
            } else {
                conversionMap[c1] = c2;
                uniqueCharsInStr2.insert(c2);
            }
        }

        return uniqueCharsInStr2.size() < 26;
    }
};