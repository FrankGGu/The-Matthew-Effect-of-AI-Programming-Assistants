#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int* smallestSufficientTeam(char** req_skills, int req_skillsSize, char*** people, int peopleSize, int* peopleColSize, int* returnSize) {
    // Precompute person skill masks
    int* person_skill_masks = (int*)malloc(peopleSize * sizeof(int));
    for (int i = 0; i < peopleSize; ++i) {
        int current_person_mask = 0;
        for (int j = 0; j < peopleColSize[i]; ++j) {
            char* skill = people[i][j];
            // Find skill index
            for (int k = 0; k < req_skillsSize; ++k) {
                if (strcmp(skill, req_skills[k]) == 0) {
                    current_person_mask |= (1 << k);
                    break;
                }
            }
        }
        person_skill_masks[i] = current_person_mask;
    }

    // DP array: dp[skill_mask] stores the bitmask of people forming the smallest team
    // for that skill_mask.
    // Each bit in the long long represents a person (0 to 59).
    int num_skill_masks = 1 << req_skillsSize;
    long long* dp = (long long*)malloc(num_skill_masks * sizeof(long long));

    // Initialize dp array
    dp[0] = 0LL; // No skills required, no people needed
    for (int i = 1; i < num_skill_masks; ++i) {
        dp[i] = -1LL; // Represents infinity (no team found yet)
    }

    // Iterate through each person
    for (int p_idx = 0; p_idx < peopleSize; ++p_idx) {
        int p_skills = person_skill_masks[p_idx];

        // Iterate through all possible skill masks in reverse order
        // This ensures that when we update dp[new_skill_mask],
        // dp[current_skill_mask] refers to the optimal team *without* considering
        // the current person (p_idx) for the current skill_mask in the same outer loop iteration.
        for (int current_skill_mask = num_skill_masks - 1; current_skill_mask >= 0; --current_skill_mask) {
            if (dp[current_skill_mask] == -1LL) {
                continue; // No valid team found for this skill_mask yet
            }

            int new_skill_mask = current_skill_mask | p_skills;

            // If adding this person doesn't add any new skills, it might still be part of a smaller team
            // if this person replaces someone else to achieve the same skills.
            // However, the current DP state `dp[current_skill_mask]` is already optimal for `current_skill_mask`.
            // Adding `p_idx` to `dp[current_skill_mask]` forms a new team `new_team_bitmask`.
            // We compare `new_team_bitmask` with `dp[new_skill_mask]`.
            long long new_team_bitmask = dp[current_skill_mask] | (1LL << p_idx);

            // Compare with existing team for new_skill_mask
            // If dp[new_skill_mask] is -1LL (infinity) or the new team is smaller
            if (dp[new_skill_mask] == -1LL || __builtin_popcountll(new_team_bitmask) < __builtin_popcountll(dp[new_skill_mask])) {
                dp[new_skill_mask] = new_team_bitmask;
            }
        }
    }

    // The result is the team for the full set of required skills
    long long final_team_bitmask = dp[num_skill_masks - 1];

    // Convert the bitmask to an array of person indices
    int team_size = __builtin_popcountll(final_team_bitmask);
    int* result = (int*)malloc(team_size * sizeof(int));
    *returnSize = team_size;

    int current_result_idx = 0;
    for (int i = 0; i < peopleSize; ++i) {
        if ((final_team_bitmask >> i) & 1LL) {
            result[current_result_idx++] = i;
        }
    }

    // Free allocated memory
    free(person_skill_masks);
    free(dp);

    return result;
}