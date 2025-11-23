class Solution {
public:
    int kBeauty(int num, int k) {
        string s = to_string(num);
        int count = 0;
        for (int i = 0; i <= s.size() - k; i++) {
            string substring = s.substr(i, k);
            if (substring[0] != '0') {
                int value = stoi(substring);
                if (num % value == 0) {
                    count++;
                }
            }
        }
        return count;
    }
};