#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <climits>

using namespace std;

long long GLOBAL_P1 = 31, GLOBAL_P2 = 37;
long long GLOBAL_M1 = 1e9 + 7, GLOBAL_M2 = 1e9 + 9;
vector<pair<long long, long long>> global_powers;

void precompute_global_powers(int max_len) {
    if (global_powers.empty() || global_powers.size() <= max_len) {
        int current_max = global_powers.empty() ? 0 : global_powers.size() - 1;
        global_powers.resize(max_len + 1);
        if (current_max == 0) global_powers[0] = {1, 1};
        for (int i = max(1, current_max + 1); i <= max_len; ++i) {
            global_powers[i].first = (global_powers[i-1].first * GLOBAL_P1) % GLOBAL_M1;
            global_powers[i].second = (global_powers[i-1].second * GLOBAL_P2) % GLOBAL_M2;
        }
    }
}

class StringPrefixHasher {
public:
    vector<pair<long long, long long>> prefix_hashes;

    StringPrefixHasher(const string& s) {
        prefix_hashes.resize(s.length() + 1);
        prefix_hashes[0] = {0, 0};
        for (int i = 0; i < s.length(); ++i) {
            prefix_hashes[i+1].first = (prefix_hashes[i].first * GLOBAL_P1 + (s[i] - 'a' + 1)) % GLOBAL_M1;
            prefix_hashes[i+1].second = (prefix_hashes[i].second * GLOBAL_P2 + (s[i] - 'a' + 1)) % GLOBAL_M2;
        }
    }

    pair<long long, long long> get_substring_hash(int start_idx, int len) {
        if (len == 0) return {0, 0};
        long long h1 = (prefix_hashes[start_idx + len].first - (prefix_hashes[start_idx].first * global_powers[len].first) % GLOBAL_M1 + GLOBAL_M1) % GLOBAL_M1;
        long long h2 = (prefix_hashes[start_idx + len].second - (prefix_hashes[start_idx].second * global_powers[len].second) % GLOBAL_M2 + GLOBAL_M2) % GLOBAL_M2;
        return {h1, h2};
    }
};

pair<long long, long long> get_string_hash_for_rule(const string& s) {
    long long h1 = 0, h2 = 0;
    for (char c : s) {
        h1 = (h1 * GLOBAL_P1 + (c - 'a' + 1)) % GLOBAL_M1;
        h2 = (h2 * GLOBAL_P2 + (c - 'a' + 1)) % GLOBAL_M2;
    }
    return {h1, h2};
}

struct FullHash {
    pair<long long, long long> source_hash;
    pair<long long, long long> target_hash;

    bool operator<(const FullHash& other) const {
        if (source_hash.first != other.source_hash.first) return source_hash.first < other.source_hash.first;
        if (source_hash.second != other.source_hash.second) return source_hash.second < other.source_hash.second;
        if (target_hash.first != other.target_hash.first) return target_hash.first < other.target_hash.first;
        return target_hash.second < other.target_hash.second;
    }
};

class Solution {
public:
    long long minimumCost(string source, string target, vector<string>& original, vector<string>& changed, vector<int>& cost) {
        ios_base::sync_with_stdio(false);
        cin.tie(NULL);

        const long long INF = LLONG_MAX / 2; // Use LLONG_MAX / 2 to prevent overflow during additions
        const int ALPHABET_SIZE = 26;

        // 1. Floyd-Warshall for single character conversions
        vector<vector<long long>> min_char_cost(ALPHABET_SIZE, vector<long long>(ALPHABET_SIZE, INF));
        for (int i = 0; i < ALPHABET_SIZE; ++i) {
            min_char_cost[i][i] = 0;
        }

        for (int i = 0; i < original.size(); ++i) {
            if (original[i].length() == 1) {
                int u = original[i][0] - 'a';
                int v = changed[i][0] - 'a';
                min_char_cost[u][v] = min(min_char_cost[u][v], (long long)cost[i]);
            }
        }

        for (int k = 0; k < ALPHABET_SIZE; ++k) {
            for (int i = 0; i < ALPHABET_SIZE; ++i) {
                for (int j = 0; j < ALPHABET_SIZE; ++j) {
                    if (min_char_cost[i][k] != INF && min_char_cost[k][j] != INF) {
                        min_char_cost[i][j] = min(min_char_cost[i][j], min_char_cost[i][k] + min_char_cost[k][j]);
                    }
                }
            }
        }

        // 2. String Hashing Setup
        int max_len_rule = 0;
        for (const string& s : original) {
            max_len_rule = max(max_len_rule, (int)s.length());
        }

        precompute_global_powers(max(source.length(), max_len_rule));

        StringPrefixHasher source_hasher(source);
        StringPrefixHasher target_hasher(target);

        vector<map<FullHash, long long>> min_substring_costs_by_len(max_len_rule + 1);

        for (int i = 0; i < original.size(); ++i) {
            int len = original[i].length();
            if (len == 0) continue; 

            pair<long long, long long> orig_h = get_string_hash_for_rule(original[i]);
            pair<long long, long long> chg_h = get_string_hash_for_rule(changed[i]);

            FullHash current_full_hash = {orig_h, chg_h};
            if (min_substring_costs_by_len[len].find(current_full_hash) == min_substring_costs_by_len[len].end()) {
                min_substring_costs_by_len[len][current_full_hash] = cost[i];
            } else {
                min_substring_costs_by_len[len][current_full_hash] = min(min_substring_costs_by_len[len][current_full_hash], (long long)cost[i]);
            }
        }

        // 3. Dynamic Programming
        int N = source.length();
        vector<long long> dp(N + 1, INF);
        dp[0] = 0;

        for (int i = 1; i <= N; ++i) {
            // Option 1: Convert source[i-1] to target[i-1] individually
            if (min_char_cost[source[i-1]-'a'][target[i-1]-'a'] != INF) {
                if (dp[i-1] != INF) {
                    dp[i] = min(dp[i], dp[i-1] + min_char_cost[source[i-1]-'a'][target[i-1]-'a']);
                }
            }

            // Option 2: Convert a substring source[j...i-1] to target[j...i-1]
            for (int len = 1; len <= i; ++len) {
                if (len > max_len_rule) break; // Optimization: no rules for this length

                int j = i - len; // start index of substring in source/target

                pair<long long, long long> src_sub_hash = source_hasher.get_substring_hash(j, len);
                pair<long long, long long> tgt_sub_hash = target_hasher.get_substring_hash(j, len);
                FullHash current_full_hash = {src_sub_hash, tgt_sub_hash};

                if (min_substring_costs_by_len[len].count(current_full_hash)) {
                    long long conversion_cost = min_substring_costs_by_len[len][current_full_hash];
                    if (dp[j] != INF) {
                        dp[i] = min(dp[i], dp[j] + conversion_cost);
                    }
                }
            }
        }

        return dp[N] == INF ? -1 : dp[N];
    }
};