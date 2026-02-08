#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int carFleet(int target, vector<int>& position, vector<int>& speed) {
        vector<pair<int, double>> cars;
        for (int i = 0; i < position.size(); ++i) {
            cars.push_back({position[i], (double)(target - position[i]) / speed[i]});
        }

        sort(cars.begin(), cars.end());

        stack<double> st;
        for (int i = cars.size() - 1; i >= 0; --i) {
            if (st.empty() || cars[i].second > st.top()) {
                st.push(cars[i].second);
            }
        }

        return st.size();
    }
};