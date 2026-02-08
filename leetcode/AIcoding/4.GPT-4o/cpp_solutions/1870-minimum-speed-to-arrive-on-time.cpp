class Solution {
public:
    int minSpeedOnTime(vector<int>& dist, double hour) {
        int left = 1, right = 1e7, res = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            double time = 0.0;

            for (int i = 0; i < dist.size(); ++i) {
                time += ceil((double)dist[i] / mid);
            }

            if (i < dist.size() - 1) {
                time += (double)dist[i] / mid;
            }

            if (time <= hour) {
                res = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return res;
    }
};