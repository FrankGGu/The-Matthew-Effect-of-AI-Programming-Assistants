class Solution {
public:
    string licenseKeyFormatting(string s, int k) {
        string result;
        for (char c : s) {
            if (c != '-') {
                result += toupper(c);
            }
        }
        int n = result.size();
        int firstGroupSize = n % k;
        int index = 0;

        if (firstGroupSize > 0) {
            result = result.substr(0, firstGroupSize) + "-" + result.substr(firstGroupSize);
            index = firstGroupSize + 1;
        } else {
            index = k;
        }

        while (index < result.size()) {
            result.insert(index, "-");
            index += k + 1;
        }

        if (result[0] == '-') {
            result.erase(0, 1);
        }

        return result;
    }
};