class Solution {
public:
    bool escapeGhosts(vector<vector<int>>& ghosts, vector<int>& target) {
        int distToTarget = abs(target[0]) + abs(target[1]);
        for (const auto& ghost : ghosts) {
            int distToGhost = abs(ghost[0] - target[0]) + abs(ghost[1] - target[1]);
            if (distToGhost <= distToTarget) {
                return false;
            }
        }
        return true;
    }
};