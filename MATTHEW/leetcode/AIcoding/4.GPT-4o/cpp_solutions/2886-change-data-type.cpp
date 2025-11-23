class Solution {
public:
    vector<string> changeDataType(vector<string>& data) {
        vector<string> result;
        for (const auto& str : data) {
            if (isdigit(str[0]) || (str[0] == '-' && str.size() > 1 && isdigit(str[1]))) {
                result.push_back(to_string(stoi(str)));
            } else {
                result.push_back(str);
            }
        }
        return result;
    }
};