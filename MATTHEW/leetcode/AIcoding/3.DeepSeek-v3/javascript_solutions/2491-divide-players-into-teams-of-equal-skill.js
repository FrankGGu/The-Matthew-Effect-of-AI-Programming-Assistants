var dividePlayers = function(skill) {
    skill.sort((a, b) => a - b);
    const n = skill.length;
    const k = skill[0] + skill[n - 1];
    let totalChemistry = 0;

    for (let i = 0; i < n / 2; i++) {
        const currentSum = skill[i] + skill[n - 1 - i];
        if (currentSum !== k) {
            return -1;
        }
        totalChemistry += skill[i] * skill[n - 1 - i];
    }

    return totalChemistry;
};