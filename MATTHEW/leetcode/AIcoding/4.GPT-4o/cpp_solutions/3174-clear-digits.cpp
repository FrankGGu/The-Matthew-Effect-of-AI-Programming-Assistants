class Solution {
public:
    int clearDigits(int num) {
        string str_num = to_string(num);
        string result = "";
        for (char c : str_num) {
            if (c != '0' && c != '1') {
                result += c;
            }
        }
        return result.empty() ? 0 : stoi(result);
    }
};