class Solution {
public:
    int countGoodStrings(int low, int high, string s) {
        int n = s.size();
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }

        int res = 0;
        for (int len = low; len <= high; len++) {
            if (canForm(count, len)) {
                res++;
            }
        }
        return res;
    }

private:
    bool canForm(vector<int>& count, int len) {
        int total = 0;
        for (int c : count) {
            total += c / len;
        }
        return total > 0;
    }
};