class Solution {
public:
    bool canTransform(string start, string end) {
        if (start.replace(start.find('X'), 1, " ") != end.replace(end.find('X'), 1, " ")) return false;

        int n = start.size();
        int i = 0, j = 0;

        while (i < n || j < n) {
            while (i < n && start[i] == 'X') i++;
            while (j < n && end[j] == 'X') j++;

            if (i < n && j < n) {
                if (start[i] != end[j]) return false;
                if ((start[i] == 'L' && i < j) || (start[i] == 'R' && i > j)) return false;
                i++;
                j++;
            } else {
                break;
            }
        }
        return true;
    }
};