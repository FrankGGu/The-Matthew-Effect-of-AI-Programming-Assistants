class Solution {
public:
    std::vector<long long> kthNearestObstacleQueries(std::vector<std::vector<int>>& obstacles, std::vector<std::vector<int>>& queries) {
        std::vector<long long> results;
        for (const auto& query : queries) {
            long long qx = query[0];
            long long qy = query[1];
            int k = query[2];

            std::vector<long long> distances;
            distances.reserve(obstacles.size());
            for (const auto& obs : obstacles) {
                long long ox = obs[0];
                long long oy = obs[1];
                long long dx = qx - ox;
                long long dy = qy - oy;
                distances.push_back(dx * dx + dy * dy);
            }

            if (k > 0 && k <= distances.size()) {
                std::nth_element(distances.begin(), distances.begin() + k - 1, distances.end());
                results.push_back(distances[k - 1]);
            } else {
                // Handle invalid k or empty obstacles case if necessary,
                // but usually problem constraints guarantee valid k.
                // For now, assuming valid k.
                results.push_back(-1); // Or some other error indicator
            }
        }
        return results;
    }
};