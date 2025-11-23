class Solution {
public:
    int numTeams(vector<int>& rating) {
        int count = 0;
        int n = rating.size();

        for (int i = 0; i < n; ++i) {
            int lessLeft = 0, greaterLeft = 0, lessRight = 0, greaterRight = 0;
            for (int j = 0; j < n; ++j) {
                if (j < i) {
                    if (rating[j] < rating[i]) lessLeft++;
                    if (rating[j] > rating[i]) greaterLeft++;
                } else if (j > i) {
                    if (rating[j] < rating[i]) lessRight++;
                    if (rating[j] > rating[i]) greaterRight++;
                }
            }
            count += lessLeft * greaterRight + greaterLeft * lessRight;
        }

        return count;
    }
};