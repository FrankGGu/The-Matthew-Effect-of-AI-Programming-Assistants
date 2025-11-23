class Solution {
public:
    bool isSymmetric(int num) {
        string s = to_string(num);
        string t = s;
        reverse(t.begin(), t.end());
        return s == t;
    }

    int countSymmetricIntegers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; ++i) {
            if (to_string(i).length() % 2 == 0 && isSymmetric(i)) {
                count++;
            }
        }
        return count;
    }
};