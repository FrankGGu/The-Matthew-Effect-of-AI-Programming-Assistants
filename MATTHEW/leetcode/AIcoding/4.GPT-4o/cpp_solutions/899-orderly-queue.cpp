class Solution {
public:
    string orderlyQueue(string s, int k) {
        if (k == 1) {
            string smallest = s;
            for (int i = 0; i < s.size(); ++i) {
                string rotated = s.substr(i) + s.substr(0, i);
                if (rotated < smallest) {
                    smallest = rotated;
                }
            }
            return smallest;
        } else {
            sort(s.begin(), s.end());
            return s;
        }
    }
};