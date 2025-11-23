class Solution {
public:
    vector<double> missingObservations(vector<int>& observations, int expected) {
        vector<double> result;
        int n = observations.size();
        int missingCount = expected - n;

        if (missingCount == 0) return result;

        double sumObservations = accumulate(observations.begin(), observations.end(), 0LL);
        double totalSum = (expected * (expected + 1)) / 2.0;
        double missingSum = totalSum - sumObservations;

        double average = missingSum / missingCount;

        for (int i = 0; i < missingCount; i++) {
            result.push_back(average);
        }

        return result;
    }
};