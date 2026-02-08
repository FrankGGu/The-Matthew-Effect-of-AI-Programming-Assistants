class Solution {
public:
    int maxLengthBetweenEqualCharacters(string s) {
        unordered_map<char, int> indices;
        int maxLength = -1;

        for (int i = 0; i < s.size(); ++i) {
            if (indices.find(s[i]) == indices.end()) {
                indices[s[i]] = i;
            } else {
                maxLength = max(maxLength, i - indices[s[i]] - 1);
            }
        }

        return maxLength;
    }
};