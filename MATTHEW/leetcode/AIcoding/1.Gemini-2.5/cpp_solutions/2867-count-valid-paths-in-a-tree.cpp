#include <vector>
#include <numeric>
#include <algorithm>
#include <queue>

class Solution {
public:
    long long countPaths(int n, std::vector<std::vector<int>>& edges) {
        // Step 1: Sieve of Eratosthenes to precompute primes up to n
        std::vector<bool> is_prime(n + 1, true);
        is_prime[0] = is_prime[1] = false;
        for (int p = 2; p * p <= n; ++p) {
            if (is_prime[p]) {
                for (int i = p * p; i <= n; i += p)
                    is_prime[i] = false;
            }
        }

        // Step 2: Build adjacency list for the tree
        std::vector<std::vector<int>> adj(n + 1);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        long long total_valid_paths = 0;

        // Step 3: Iterate through each node
        for (int i = 1; i <= n; ++i) {
            if (is_prime[i]) {
                long long current_non_prime_sum = 0; // Sum of sizes of non-prime components connected to current prime 'i'

                // visited_for_current_prime tracks nodes visited during the BFS runs for the current prime 'i'.
                // This ensures that:
                // 1. A non-prime node is not counted multiple times if reachable from different neighbors of 'i'
                //    through non-prime paths within the same connected component.
                // 2. The BFS for a non-prime component correctly stops at prime nodes (including 'i').
                std::vector<bool> visited_for_current_prime(n + 1, false); 
                visited_for_current_prime[i] = true; // Mark the prime node itself as visited to prevent BFS from crossing it

                // For each neighbor of the prime node 'i'
                for (int neighbor : adj[i]) {
                    // If the neighbor is not prime and hasn't been visited yet during this prime's processing
                    if (!is_prime[neighbor] && !visited_for_current_prime[neighbor]) {
                        long long component_size = 0;
                        std::queue<int> q; 
                        q.push(neighbor);
                        visited_for_current_prime[neighbor] = true;

                        // BFS to find the size of the connected component of non-prime nodes
                        while(!q.empty()){
                            int curr = q.front();
                            q.pop();
                            component_size++;
                            for(int next_node : adj[curr]){
                                // Only traverse to non-prime, unvisited nodes
                                if(!is_prime[next_node] && !visited_for_current_prime[next_node]){
                                    visited_for_current_prime[next_node] = true;
                                    q.push(next_node);
                                }
                            }
                        }

                        // Add paths:
                        // 1. Paths from prime 'i' to any node in this component: `component_size` paths
                        total_valid_paths += component_size;

                        // 2. Paths from a node in a previously found non-prime component (connected to 'i')
                        //    through 'i' to a node in the current component: `current_non_prime_sum * component_size` paths
                        total_valid_paths += current_non_prime_sum * component_size;

                        // Add current component's size to the sum for future calculations for this prime 'i'
                        current_non_prime_sum += component_size;
                    }
                }
            }
        }

        return total_valid_paths;
    }
};