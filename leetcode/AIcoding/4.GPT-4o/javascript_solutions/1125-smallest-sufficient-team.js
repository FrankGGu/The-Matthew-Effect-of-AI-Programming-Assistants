var smallestSufficientTeam = function(req_skills, people) {
    const skillIndex = new Map();
    req_skills.forEach((skill, index) => skillIndex.set(skill, index));

    const dp = new Map();
    dp.set(0, []);

    for (let i = 0; i < people.length; i++) {
        const personSkills = people[i].reduce((mask, skill) => mask | (1 << skillIndex.get(skill)), 0);

        for (const [mask, team] of dp.entries()) {
            const newMask = mask | personSkills;
            if (!dp.has(newMask) || dp.get(newMask).length > team.length + 1) {
                dp.set(newMask, [...team, i]);
            }
        }
    }

    return dp.get((1 << req_skills.length) - 1);
};