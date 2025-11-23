class Solution {
public:
    double minimumFinishTime(vector<int>& tires, int changeTime, int numLaps) {
        int n = tires.size();
        vector<double> minTime(numLaps + 1, DBL_MAX);
        minTime[0] = 0;

        for (int i = 1; i <= numLaps; ++i) {
            for (int j = 0; j < n; ++j) {
                long long time = tires[j];
                double totalTime = time;

                for (int k = 1; k <= i; ++k) {
                    if (totalTime >= DBL_MAX) break;
                    minTime[i] = min(minTime[i], minTime[i - k] + totalTime + (k - 1) * changeTime);
                    time *= 2;
                    totalTime += time;
                }
            }
        }
        return minTime[numLaps];
    }
};