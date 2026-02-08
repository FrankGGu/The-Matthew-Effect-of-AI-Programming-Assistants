class Solution {
public:
    int maxRunTime(int n, vector<int>& batteries) {
        long long totalEnergy = accumulate(batteries.begin(), batteries.end(), 0LL);
        long long left = 1, right = totalEnergy / n;

        while (left < right) {
            long long mid = right - (right - left) / 2;
            if (canRun(mid, n, batteries)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        return left;
    }

    bool canRun(long long time, int n, vector<int>& batteries) {
        long long neededEnergy = n * time;
        long long availableEnergy = 0;

        for (auto battery : batteries) {
            availableEnergy += min((long long)battery, time);
        }

        return availableEnergy >= neededEnergy;
    }
};