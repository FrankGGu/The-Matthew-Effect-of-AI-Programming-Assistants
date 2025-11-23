class Solution {
public:
    bool reorderedPowerOf2(int N) {
        vector<int> count(10, 0);
        string strN = to_string(N);
        for (char c : strN) count[c - '0']++;

        for (int i = 0; i < 31; i++) {
            int powerOf2 = 1 << i;
            vector<int> count2(10, 0);
            string strPowerOf2 = to_string(powerOf2);
            for (char c : strPowerOf2) count2[c - '0']++;
            if (count == count2) return true;
        }
        return false;
    }
};