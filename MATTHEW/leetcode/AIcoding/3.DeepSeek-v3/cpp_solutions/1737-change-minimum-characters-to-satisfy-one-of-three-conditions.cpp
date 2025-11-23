class Solution {
public:
    int minCharacters(string a, string b) {
        vector<int> countA(26, 0), countB(26, 0);
        for (char c : a) countA[c - 'a']++;
        for (char c : b) countB[c - 'a']++;

        int totalA = a.size(), totalB = b.size();
        int res = totalA + totalB;

        for (int i = 0; i < 26; ++i) {
            res = min(res, totalA + totalB - countA[i] - countB[i]);
        }

        int sumA = 0, sumB = 0;
        for (int i = 0; i < 25; ++i) {
            sumA += countA[i];
            sumB += countB[i];
            res = min(res, sumA + totalB - sumB);
            res = min(res, sumB + totalA - sumA);
        }

        return res;
    }
};