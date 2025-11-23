class Solution {
public:
    int carFleet(int target, vector<int>& position, vector<int>& speed) {
        int n = position.size();
        vector<pair<double, double>> cars(n);

        for (int i = 0; i < n; ++i) {
            cars[i] = {static_cast<double>(position[i]), static_cast<double>(speed[i])};
        }

        sort(cars.begin(), cars.end(), greater<pair<double, double>>());

        stack<double> stack;
        for (auto& car : cars) {
            double time = (target - car.first) / car.second;
            if (stack.empty() || time > stack.top()) {
                stack.push(time);
            }
        }

        return stack.size();
    }
};