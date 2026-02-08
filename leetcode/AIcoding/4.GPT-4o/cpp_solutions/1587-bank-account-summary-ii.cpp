class Solution {
public:
    vector<string> bankSummary(vector<int>& balance) {
        long long sum = 0;
        int count = 0;
        for (int b : balance) {
            if (b > 0) {
                count++;
            }
            sum += b;
        }
        return {to_string(sum), to_string(count)};
    }
};