/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* smallestSufficientTeam(char** req_skills, int req_skillsSize, char*** people, int peopleSize, int* peopleColSize, int* returnSize) {
    int n = req_skillsSize;
    int m = peopleSize;

    // Map skills to indices
    int skill_index[100] = {0};
    for (int i = 0; i < n; i++) {
        skill_index[i] = i;
    }

    // Convert people's skills to bitmask
    int people_skills[m];
    for (int i = 0; i < m; i++) {
        int mask = 0;
        for (int j = 0; j < peopleColSize[i]; j++) {
            for (int k = 0; k < n; k++) {
                if (strcmp(people[i][j], req_skills[k]) == 0) {
                    mask |= (1 << k);
                    break;
                }
            }
        }
        people_skills[i] = mask;
    }

    // DP arrays
    long long dp[1 << n];
    int team_size[1 << n];
    long long team_mask[1 << n];

    for (int i = 0; i < (1 << n); i++) {
        dp[i] = (1LL << m) - 1; // All people selected
        team_size[i] = m;
        team_mask[i] = (1LL << m) - 1;
    }

    dp[0] = 0;
    team_size[0] = 0;
    team_mask[0] = 0;

    for (int i = 0; i < m; i++) {
        int skill = people_skills[i];
        for (int j = (1 << n) - 1; j >= 0; j--) {
            int new_mask = j | skill;
            if (team_size[j] + 1 < team_size[new_mask]) {
                team_size[new_mask] = team_size[j] + 1;
                team_mask[new_mask] = team_mask[j] | (1LL << i);
                dp[new_mask] = team_mask[new_mask];
            } else if (team_size[j] + 1 == team_size[new_mask]) {
                long long new_team = team_mask[j] | (1LL << i);
                if (new_team < dp[new_mask]) {
                    dp[new_mask] = new_team;
                    team_mask[new_mask] = new_team;
                }
            }
        }
    }

    int target = (1 << n) - 1;
    long long result_mask = dp[target];

    // Count number of people in the team
    int count = 0;
    for (int i = 0; i < m; i++) {
        if (result_mask & (1LL << i)) {
            count++;
        }
    }

    // Build result array
    int* result = (int*)malloc(count * sizeof(int));
    int idx = 0;
    for (int i = 0; i < m; i++) {
        if (result_mask & (1LL << i)) {
            result[idx++] = i;
        }
    }

    *returnSize = count;
    return result;
}