class Solution {
public:
    bool canTransform(string start, string end) {
        int n = start.size();
        if (start.replace(start.find('X'), string::npos, "") != end.replace(end.find('X'), string::npos, "")) {
            return false;
        }

        int j = 0;
        for (int i = 0; i < n; ++i) {
            if (start[i] != 'X') {
                while (j < n && end[j] == 'X') j++;
                if (j == n || start[i] != end[j] || (start[i] == 'L' && i < j) || (start[i] == 'R' && i > j)) {
                    return false;
                }
                j++;
            }
        }
        return true;
    }
};