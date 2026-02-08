class Solution {
public:
    int racecar(int target) {
        queue<pair<int, int>> q; // position, speed
        unordered_set<string> visited;
        q.push({0, 1});
        visited.insert("0,1");
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; i++) {
                auto [pos, speed] = q.front();
                q.pop();

                if (pos == target) return steps;

                // Next position with current speed
                int next_pos = pos + speed;
                int next_speed = speed * 2;
                string state1 = to_string(next_pos) + "," + to_string(next_speed);
                if (abs(next_pos) < 2 * target && !visited.count(state1)) {
                    visited.insert(state1);
                    q.push({next_pos, next_speed});
                }

                // Stop and reverse
                next_pos = pos;
                next_speed = speed > 0 ? -1 : 1;
                string state2 = to_string(next_pos) + "," + to_string(next_speed);
                if (!visited.count(state2)) {
                    visited.insert(state2);
                    q.push({next_pos, next_speed});
                }
            }
            steps++;
        }
        return -1; // This line will never be reached
    }
};