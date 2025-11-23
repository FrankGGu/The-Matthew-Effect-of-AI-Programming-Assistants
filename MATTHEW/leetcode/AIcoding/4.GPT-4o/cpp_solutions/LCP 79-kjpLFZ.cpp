class Solution {
public:
    string magicalString(int n) {
        if (n == 0) return "";
        if (n == 1) return "1";

        string result = "1";
        int count = 1;
        int index = 1;

        while (result.size() < n) {
            int num = result[index] - '0';
            char nextChar = (count % 2 == 0) ? '2' : '1';
            for (int i = 0; i < num && result.size() < n; ++i) {
                result += nextChar;
            }
            count++;
            index++;
        }

        return result.substr(0, n);
    }
};