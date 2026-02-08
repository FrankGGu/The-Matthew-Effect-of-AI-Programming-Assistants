class Solution {
public:
    string strWithout3a3b(int A, int B) {
        string result;
        while (A > 0 || B > 0) {
            if (A > B) {
                if (A > 1) {
                    result += "aa";
                    A -= 2;
                } else {
                    result += "a";
                    A--;
                }
                if (B > 0) {
                    result += "b";
                    B--;
                }
            } else {
                if (B > 1) {
                    result += "bb";
                    B -= 2;
                } else {
                    result += "b";
                    B--;
                }
                if (A > 0) {
                    result += "a";
                    A--;
                }
            }
        }
        return result;
    }
};