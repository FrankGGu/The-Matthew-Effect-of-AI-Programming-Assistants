#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string rankTeams(std::vector<std::string>& votes) {
        if (votes.empty()) {
            return "";
        }

        int num_teams = votes[0].length();

        // counts[team_idx][rank_idx] stores how many times a team received a specific rank.
        // team_idx: 0 for 'A', 1 for 'B', ..., 25 for 'Z'.
        // rank_idx: 0 for 1st place, 1 for 2nd place, ..., num_teams-1 for last place.
        std::vector<std::vector<int>> counts(26, std::vector<int>(num_teams, 0));

        // Populate the counts array based on the votes.
        for (const std::string& vote : votes) {
            for (int rank_idx = 0; rank_idx < num_teams; ++rank_idx) {
                char team_char = vote[rank_idx];
                counts[team_char - 'A'][rank_idx]++;
            }
        }

        // Initialize the result string with the teams from the first vote.
        // This string will be sorted according to the ranking rules.
        std::string result_teams = votes[0];

        // Sort the teams using a custom lambda comparator.
        std::sort(result_teams.begin(), result_teams.end(), [&](char t1, char t2) {
            // Compare the vote counts for each rank.
            for (int rank_idx = 0; rank_idx < num_teams; ++rank_idx) {
                int count1 = counts[t1 - 'A'][rank_idx];
                int count2 = counts[t2 - 'A'][rank_idx];

                if (count1 != count2) {
                    // If counts differ, the team with more votes at this rank comes first.
                    return count1 > count2;
                }
            }
            // If all ranks are tied, sort alphabetically (lexicographically).
            return t1 < t2;
        });

        return result_teams;
    }
};