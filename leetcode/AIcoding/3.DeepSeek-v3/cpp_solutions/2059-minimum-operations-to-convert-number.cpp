class Solution {
public:
    int minimumOperations(vector<int>& nums, int start, int goal) {
        queue<int> q;
        q.push(start);
        unordered_set<int> visited;
        visited.insert(start);
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int current = q.front();
                q.pop();

                if (current == goal) {
                    return steps;
                }

                if (current < 0 || current > 1000) {
                    continue;
                }

                for (int num : nums) {
                    int next1 = current + num;
                    if (next1 == goal) return steps + 1;
                    if (next1 >= 0 && next1 <= 1000 && visited.find(next1) == visited.end()) {
                        visited.insert(next1);
                        q.push(next1);
                    }

                    int next2 = current - num;
                    if (next2 == goal) return steps + 1;
                    if (next2 >= 0 && next2 <= 1000 && visited.find(next2) == visited.end()) {
                        visited.insert(next2);
                        q.push(next2);
                    }

                    int next3 = current ^ num;
                    if (next3 == goal) return steps + 1;
                    if (next3 >= 0 && next3 <= 1000 && visited.find(next3) == visited.end()) {
                        visited.insert(next3);
                        q.push(next3);
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};