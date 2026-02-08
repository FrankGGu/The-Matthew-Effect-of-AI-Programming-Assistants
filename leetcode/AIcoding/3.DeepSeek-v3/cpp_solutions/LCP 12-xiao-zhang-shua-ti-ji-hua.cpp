class Solution {
public:
    int minTime(vector<int>& time, int m) {
        int left = 0, right = accumulate(time.begin(), time.end(), 0);
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canFinish(time, m, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

private:
    bool canFinish(const vector<int>& time, int m, int T) {
        int sum = 0, maxT = 0, days = 1;
        for (int t : time) {
            sum += t;
            maxT = max(maxT, t);
            if (sum - maxT > T) {
                days++;
                sum = t;
                maxT = t;
                if (days > m) {
                    return false;
                }
            }
        }
        return true;
    }
};