#include <string>
#include <vector>
#include <queue>
#include <algorithm> // For std::reverse

class Solution {
public:
    std::string smallestDivisibleDigitProductII(int n) {
        if (n == 1) {
            return "1";
        }

        // parent[remainder] stores {previous_remainder, digit_used_to_reach_here}.
        // A previous_remainder of 0 is used as a special sentinel to indicate
        // that the current remainder was reached by an initial single digit.
        std::vector<std::pair<int, int>> parent(n, {-1, -1});

        // dist[remainder] stores the length of the shortest number found for that remainder.
        // -1 means the remainder has not been visited yet.
        std::vector<int> dist(n, -1);

        // Queue for BFS, storing remainders.
        std::queue<int> q;

        // Initialize BFS with single digits from 1 through 9.
        // These are the starting points for forming numbers.
        for (int d = 1; d <= 9; ++d) {
            int rem = d % n;
            if (dist[rem] == -1) { // If this remainder hasn't been visited yet
                dist[rem] = 1; // Length of the number is 1
                parent[rem] = {0, d}; // Store {sentinel_prev_rem, digit}
                q.push(rem);
            }
        }

        // Perform BFS to find the shortest number (in terms of digits)
        // that is divisible by n, and then among those, the lexicographically smallest.
        while (!q.empty()) {
            int curr_rem = q.front();
            q.pop();

            // Iterate through possible next digits (1 to 9)
            for (int d = 1; d <= 9; ++d) {
                int next_rem = (curr_rem * 10 + d) % n;
                int next_len = dist[curr_rem] + 1;

                // If next_rem has not been visited, or we found a shorter path to it
                if (dist[next_rem] == -1) {
                    dist[next_rem] = next_len;
                    parent[next_rem] = {curr_rem, d};
                    q.push(next_rem);
                }
                // If a path of the same length is found, we do not update parent.
                // This is because BFS, when processing digits 1-9 in increasing order,
                // naturally finds the lexicographically smallest path among all shortest paths.
                // The first path of a certain length found for a remainder will be the
                // lexicographically smallest for that length.
            }
        }

        // After BFS, if dist[0] is still -1, it means no number divisible by n
        // (with remainder 0) was found. This case should generally not occur
        // for positive integers n and digits 1-9, as solutions should always exist.
        if (dist[0] == -1) {
            return ""; // Or handle as per problem specific requirements (e.g., "-1")
        }

        // Reconstruct the number by tracing back through the parent array,
        // starting from remainder 0.
        std::string result = "";
        int curr = 0; // Start reconstruction from the target remainder 0

        // Trace back until we hit the special sentinel parent {0, digit}
        while (parent[curr].first != 0) {
            result += std::to_string(parent[curr].second);
            curr = parent[curr].first;
        }
        // Add the very first digit of the number
        result += std::to_string(parent[curr].second); 

        // The digits were added in reverse order during reconstruction, so reverse the string.
        std::reverse(result.begin(), result.end());
        return result;
    }
};