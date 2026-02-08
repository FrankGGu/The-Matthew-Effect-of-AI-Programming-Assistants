class Solution {
public:
    int wateringPlants(vector<int>& plants, int capacity) {
        int steps = 0;
        int current = capacity;
        for (int i = 0; i < plants.size(); ++i) {
            if (current < plants[i]) {
                steps += 2 * i;
                current = capacity;
            }
            current -= plants[i];
            steps++;
        }
        return steps;
    }
};