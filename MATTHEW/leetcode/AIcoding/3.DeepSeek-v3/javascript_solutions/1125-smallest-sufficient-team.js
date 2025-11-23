var smallestSufficientTeam = function(req_skills, people) {
    const skillToIndex = new Map();
    req_skills.forEach((skill, index) => {
        skillToIndex.set(skill, index);
    });

    const n = req_skills.length;
    const target = (1 << n) - 1;
    const dp = new Array(1 << n).fill(null);
    dp[0] = [];

    for (let i = 0; i < people.length; i++) {
        const personSkills = people[i];
        let personMask = 0;
        for (const skill of personSkills) {
            personMask |= (1 << skillToIndex.get(skill));
        }

        for (let mask = 0; mask < dp.length; mask++) {
            if (dp[mask] === null) continue;
            const newMask = mask | personMask;
            if (dp[newMask] === null || dp[mask].length + 1 < dp[newMask].length) {
                dp[newMask] = [...dp[mask], i];
            }
        }
    }

    return dp[target];
};