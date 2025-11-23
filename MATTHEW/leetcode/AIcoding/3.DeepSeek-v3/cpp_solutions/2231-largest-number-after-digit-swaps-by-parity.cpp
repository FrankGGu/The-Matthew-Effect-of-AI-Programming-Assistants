class Solution {
public:
    int largestInteger(int num) {
        string s = to_string(num);
        vector<char> odd, even;
        for (char c : s) {
            int digit = c - '0';
            if (digit % 2 == 0) {
                even.push_back(c);
            } else {
                odd.push_back(c);
            }
        }
        sort(odd.rbegin(), odd.rend());
        sort(even.rbegin(), even.rend());
        int oddIdx = 0, evenIdx = 0;
        string res;
        for (char c : s) {
            int digit = c - '0';
            if (digit % 2 == 0) {
                res += even[evenIdx++];
            } else {
                res += odd[oddIdx++];
            }
        }
        return stoi(res);
    }
};