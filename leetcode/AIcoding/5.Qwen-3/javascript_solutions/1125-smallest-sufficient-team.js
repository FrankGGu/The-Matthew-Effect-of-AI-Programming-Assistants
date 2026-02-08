function bestTeamWithNoConflicts(people) {
    people.sort((a, b) => a[0] - b[0]);
    const dp = {};
    for (let i = 0; i < people.length; i++) {
        const [skill, age] = people[i];
        dp[skill] = Math.min(dp[skill] || Infinity, age);
        for (let j = 0; j < i; j++) {
            const [s, a] = people[j];
            if (s < skill) {
                const newSkill = skill + s;
                dp[newSkill] = Math.min(dp[newSkill] || Infinity, dp[s] + age);
            }
        }
    }
    return Math.min(...Object.values(dp));
}