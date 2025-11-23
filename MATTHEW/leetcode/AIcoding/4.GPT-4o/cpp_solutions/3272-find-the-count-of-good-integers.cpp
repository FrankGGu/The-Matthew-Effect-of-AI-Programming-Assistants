class Solution {
public:
    int countGoodIntegers(int low, int high) {
        int count = 0;
        for (long long i = low; i <= high; i++) {
            string s = to_string(i);
            if (s.size() > 1 && s[0] == s[1]) {
                bool isGood = true;
                for (int j = 1; j < s.size(); j++) {
                    if (s[j] != s[0]) {
                        isGood = false;
                        break;
                    }
                }
                if (isGood) count++;
            } else if (s.size() == 1) {
                count++;
            }
        }
        return count;
    }
};