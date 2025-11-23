class Solution {
public:
    int repeatedStringMatch(string a, string b) {
        int count = 1;
        string temp = a;
        while (temp.size() < b.size()) {
            temp += a;
            count++;
        }
        if (temp.find(b) != string::npos) {
            return count;
        }
        temp += a;
        count++;
        if (temp.find(b) != string::npos) {
            return count;
        }
        return -1;
    }
};