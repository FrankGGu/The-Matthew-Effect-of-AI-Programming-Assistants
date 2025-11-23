var smallestSufficientTeam = function(req_skills, people) {
    const n = req_skills.length;
    const m = people.length;

    const skill_index = {};
    for (let i = 0; i < n; i++) {
        skill_index[req_skills[i]] = i;
    }

    const skill_masks = new Array(m).fill(0);
    for (let i = 0; i < m; i++) {
        for (const skill of people[i]) {
            if (skill_index.hasOwnProperty(skill)) {
                skill_masks[i] |= (1 << skill_index[skill]);
            }
        }
    }

    const dp = new Array(1 << n).fill(null);
    dp[0] = [];

    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] === null) continue;

        for (let i = 0; i < m; i++) {
            const new_mask = mask | skill_masks[i];
            if (new_mask === mask) continue;

            if (dp[new_mask] === null || dp[new_mask].length > dp[mask].length + 1) {
                dp[new_mask] = [...dp[mask], i];
            }
        }
    }

    return dp[(1 << n) - 1];
};