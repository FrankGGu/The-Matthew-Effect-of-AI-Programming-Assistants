class Solution {
public:
    int numberOfBeams(vector<string>& bank) {
        int prev = 0;
        int total = 0;
        for (const string& row : bank) {
            int current = count(row.begin(), row.end(), '1');
            if (current > 0) {
                total += prev * current;
                prev = current;
            }
        }
        return total;
    }
};