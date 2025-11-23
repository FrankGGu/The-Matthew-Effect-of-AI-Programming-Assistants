class Solution {
public:
    string countAndSay(int n) {
        string result = "1";
        for (int i = 1; i < n; ++i) {
            string temp = "";
            char current = result[0];
            int count = 1;
            for (int j = 1; j < result.size(); ++j) {
                if (result[j] == current) {
                    count++;
                } else {
                    temp += to_string(count) + current;
                    current = result[j];
                    count = 1;
                }
            }
            temp += to_string(count) + current;
            result = temp;
        }
        return result;
    }
};