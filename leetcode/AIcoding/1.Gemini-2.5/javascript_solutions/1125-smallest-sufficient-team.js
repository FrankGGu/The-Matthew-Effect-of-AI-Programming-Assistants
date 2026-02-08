var smallestSufficientTeam = function(req_skills, people) {
    const numSkills = req_skills.length;
    const numPeople = people.length;

    const skillMap = new Map();
    for (let i = 0; i < numSkills; i++) {
        skillMap.set(req_skills[i], i);
    }

    const peopleSkillMasks = new Array(numPeople);
    for (let i = 0; i < numPeople; i++) {
        let currentPersonSkillsMask = 0;
        for (const skill of people[i]) {
            currentPersonSkillsMask |= (1 << skillMap.get(skill));
        }
        peopleSkillMasks[i] = currentPersonSkillsMask;
    }

    const dp = new Array(1 << numSkills).fill(Infinity);
    dp[0] = 0;

    const parent = new Array(1 << numSkills).fill(null);

    for (let mask = 0; mask < (1 << numSkills); mask++) {
        if (dp[mask] === Infinity) {
            continue;
        }

        for (let pIdx = 0; pIdx < numPeople; pIdx++) {
            const personSkillMask = peopleSkillMasks[pIdx];
            const nextMask = mask | personSkillMask;

            if (dp[mask] + 1 < dp[nextMask]) {
                dp[nextMask] = dp[mask] + 1;
                parent[nextMask] = { prevMask: mask, personIdx: pIdx };
            }
        }
    }

    const result = [];
    let currentMask = (1 << numSkills) - 1;
    while (currentMask > 0) {
        const info = parent[currentMask];
        result.push(info.personIdx);
        currentMask = info.prevMask;
    }

    return result;
};