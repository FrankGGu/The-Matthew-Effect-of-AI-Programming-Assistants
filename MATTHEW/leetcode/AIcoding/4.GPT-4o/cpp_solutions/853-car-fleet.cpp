class Solution {
public:
    int carFleet(int target, vector<int>& position, vector<int>& speed) {
        int n = position.size();
        vector<pair<double, double>> cars(n);

        for (int i = 0; i < n; i++) {
            cars[i] = {position[i], (double)(target - position[i]) / speed[i]};
        }

        sort(cars.begin(), cars.end());
        int fleets = 0;
        double lastTime = 0;

        for (int i = n - 1; i >= 0; i--) {
            if (cars[i].second > lastTime) {
                fleets++;
                lastTime = cars[i].second;
            }
        }

        return fleets;
    }
};