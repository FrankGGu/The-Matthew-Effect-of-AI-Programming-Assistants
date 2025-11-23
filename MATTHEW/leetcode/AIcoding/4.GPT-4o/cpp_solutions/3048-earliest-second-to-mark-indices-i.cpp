class Solution {
public:
    int earliestFullMark(vector<int>& marks) {
        unordered_map<int, int> count;
        int n = marks.size();
        for (int i = 0; i < n; ++i) {
            count[marks[i]]++;
            if (count.size() == n) {
                return i + 1;
            }
        }
        return -1;
    }
};