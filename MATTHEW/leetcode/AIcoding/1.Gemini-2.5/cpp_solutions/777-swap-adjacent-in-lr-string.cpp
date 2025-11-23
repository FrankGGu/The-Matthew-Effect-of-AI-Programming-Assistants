class Solution {
public:
    bool canTransform(string start, string end) {
        int n = start.length();
        if (n != end.length()) {
            return false;
        }

        int i = 0, j = 0;
        while (i < n && j < n) {
            while (i < n && start[i] == 'X') {
                i++;
            }
            while (j < n && end[j] == 'X') {
                j++;
            }

            if (i == n && j == n) {
                return true;
            }
            if (i == n || j == n) {
                return false;
            }

            if (start[i] != end[j]) {
                return false;
            }

            if (start[i] == 'L' && i < j) {
                return false;
            }
            if (start[i] == 'R' && i > j) {
                return false;
            }

            i++;
            j++;
        }

        while (i < n) {
            if (start[i] != 'X') {
                return false;
            }
            i++;
        }
        while (j < n) {
            if (end[j] != 'X') {
                return false;
            }
            j++;
        }

        return true;
    }
};