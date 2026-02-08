class Solution {
public:
    int getTriggerTime(vector<int>& time, vector<int>& position, vector<int>& speed) {
        int n = time.size();
        double maxTime = 0.0;
        for (int i = 0; i < n; ++i) {
            double t = (position[i] - speed[i] * time[i]) / (1.0 - speed[i]);
            if (t >= 0) {
                maxTime = max(maxTime, t);
            }
        }
        return static_cast<int>(ceil(maxTime));
    }
};