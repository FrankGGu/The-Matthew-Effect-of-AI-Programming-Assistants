class Solution {
public:
    int minimumStringLength(string s) {
        while (true) {
            string temp = s;
            size_t pos = s.find("AB");
            if (pos != string::npos) {
                temp.erase(pos, 2);
                s = temp;
                continue;
            }
            pos = s.find("CD");
            if (pos != string::npos) {
                temp.erase(pos, 2);
                s = temp;
                continue;
            }
            pos = s.find("EF");
            if (pos != string::npos) {
                temp.erase(pos, 2);
                s = temp;
                continue;
            }
            break;
        }
        return s.length();
    }
};