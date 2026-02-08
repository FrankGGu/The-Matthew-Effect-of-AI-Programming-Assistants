class Solution {
public:
    int numberOfBeams(vector<string>& bank) {
        int totalBeams = 0;
        int lastCount = 0;

        for (const string& row : bank) {
            int currentCount = count(row.begin(), row.end(), '1');
            if (currentCount > 0) {
                totalBeams += lastCount * currentCount;
                lastCount = currentCount;
            }
        }

        return totalBeams;
    }
};