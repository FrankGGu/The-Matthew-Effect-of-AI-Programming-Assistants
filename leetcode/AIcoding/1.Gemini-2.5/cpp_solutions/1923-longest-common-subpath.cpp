#include <vector>
#include <string>
#include <algorithm>
#include <map>
#include <set>

class Solution {
public:
    // Constants for polynomial rolling hash
    // Using two different bases and moduli to reduce collision probability
    const long long B1 = 31; // Base 1
    const long long M1 = 1e9 + 7; // Modulo 1
    const long long B2 = 37; // Base 2
    const long long M2 = 1e9 + 9; // Modulo 2

    // Precomputed powers of bases
    std::vector<long long> p_pow1;
    std::vector<long long> p_pow2;
    int max_overall_len = 0; // Maximum length among all paths

    // Helper function to check if a common subpath of length 'k' exists
    bool check(int k, int n, const std::vector<std::vector<int>>& paths) {
        if (k == 0) {
            return true; // A subpath of length 0 always exists
        }

        // Map to store frequencies of unique hash pairs across all paths
        std::map<std::pair<long long, long long>, int> counts;

        for (const auto& path : paths) {
            int m = path.size();
            if (m < k) {
                // This path is shorter than k, so it cannot contain a subpath of length k
                continue;
            }

            // Calculate prefix hashes for the current path
            std::vector<long long> h1(m + 1, 0);
            std::vector<long long> h2(m + 1, 0);
            for (int i = 0; i < m; ++i) {
                h1[i+1] = (h1[i] * B1 + path[i]) % M1;
                h2[i+1] = (h2[i] * B2 + path[i]) % M2;
            }

            // Set to store unique hash pairs for subpaths of length 'k' in the current path
            std::set<std::pair<long long, long long>> current_path_unique_hashes;
            for (int i = 0; i <= m - k; ++i) { // 'i' is the starting index of the subpath
                // Calculate hash for the subpath from index 'i' to 'i + k - 1'
                long long current_h1 = (h1[i+k] - (h1[i] * p_pow1[k]) % M1 + M1) % M1;
                long long current_h2 = (h2[i+k] - (h2[i] * p_pow2[k]) % M2 + M2) % M2;
                current_path_unique_hashes.insert({current_h1, current_h2});
            }

            // Increment counts for unique hashes found in this path
            for (const auto& hash_pair : current_path_unique_hashes) {
                counts[hash_pair]++;
            }
        }

        // Check if any hash pair has been found in all 'n' paths
        for (const auto& entry : counts) {
            if (entry.second == n) {
                return true;
            }
        }
        return false;
    }

    int longestCommonSubpath(std::vector<std::vector<int>>& paths) {
        int n = paths.size();
        if (n == 0) {
            return 0;
        }

        // Determine the minimum path length and maximum overall path length
        int min_path_len = 1e9 + 7; // Initialize with a very large value
        for (const auto& path : paths) {
            min_path_len = std::min(min_path_len, (int)path.size());
            max_overall_len = std::max(max_overall_len, (int)path.size());
        }

        // Precompute powers of bases up to max_overall_len
        // This is done once per call to longestCommonSubpath
        p_pow1.resize(max_overall_len + 1);
        p_pow2.resize(max_overall_len + 1);
        p_pow1[0] = 1; 
        p_pow2[0] = 1;
        for (int i = 1; i <= max_overall_len; ++i) {
            p_pow1[i] = (p_pow1[i-1] * B1) % M1;
            p_pow2[i] = (p_pow2[i-1] * B2) % M2;
        }

        // Binary search for the longest common subpath length
        int low = 0;
        int high = min_path_len;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, n, paths)) {
                ans = mid; // A common subpath of length 'mid' exists, try for longer
                low = mid + 1;
            } else {
                high = mid - 1; // No common subpath of length 'mid', try for shorter
            }
        }
        return ans;
    }
};