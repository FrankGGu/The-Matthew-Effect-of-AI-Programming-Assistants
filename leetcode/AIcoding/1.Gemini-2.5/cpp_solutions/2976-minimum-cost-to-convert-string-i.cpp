#include <vector>
#include <string>
#include <algorithm> // For std::min

class Solution {
public:
    long long minimumCost(std::string source, std::string target, std::vector<char>& change, std::vector<char>& cost) {
        const int ALPHABET_SIZE = 26;
        const long long INF = 1e18; // A sufficiently large number for infinity

        // Initialize the cost matrix for all character conversions.
        // dist[i][j] will store the minimum cost to convert character 'a'+i to 'a'+j.
        std::vector<std::vector<long long>> dist(ALPHABET_SIZE, std::vector<long long>(ALPHABET_SIZE, INF));

        // Cost from a character to itself is 0.
        for (int i = 0; i < ALPHABET_SIZE; ++i) {
            dist[i][i] = 0;
        }

        // Populate direct conversion costs from the 'change' and 'cost' vectors.
        // Interpretation: 'change[i]' is the original character, 'cost[i]' (char) is the target character.
        // Since no explicit integer cost vector is provided, we assume a uniform cost of 1 for each direct conversion.
        for (size_t i = 0; i < change.size(); ++i) {
            int from_char_idx = change[i] - 'a';
            int to_char_idx = cost[i] - 'a'; // Interpreting `cost[i]` (char) as the target character.
            long long conversion_cost = 1;   // Assuming a uniform cost of 1.

            // Update with the minimum direct cost if multiple paths exist for the same conversion.
            dist[from_char_idx][to_char_idx] = std::min(dist[from_char_idx][to_char_idx], conversion_cost);
        }

        // Apply Floyd-Warshall algorithm to find all-pairs shortest paths.
        // This step calculates the minimum cost to convert any character to any other character,
        // considering all possible intermediate conversions.
        for (int k = 0; k < ALPHABET_SIZE; ++k) { // Intermediate character
            for (int i = 0; i < ALPHABET_SIZE; ++i) { // Starting character
                for (int j = 0; j < ALPHABET_SIZE; ++j) { // Ending character
                    // Only update if both segments of the path (i->k and k->j) are reachable.
                    if (dist[i][k] != INF && dist[k][j] != INF) {
                        dist[i][j] = std::min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        // Calculate the total minimum cost to convert the source string to the target string.
        long long total_cost = 0;
        for (size_t i = 0; i < source.length(); ++i) {
            // If characters are already the same, no cost is incurred.
            if (source[i] == target[i]) {
                continue;
            }

            int from_char_idx = source[i] - 'a';
            int to_char_idx = target[i] - 'a';

            // If the conversion is impossible (cost remains INF), return -1.
            if (dist[from_char_idx][to_char_idx] == INF) {
                return -1;
            }
            total_cost += dist[from_char_idx][to_char_idx];
        }

        return total_cost;
    }
};