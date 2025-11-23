function dividePlayers(skill) {
    const totalSkill = skill.reduce((a, b) => a + b, 0);
    const n = skill.length;
    if (totalSkill % (n / 2) !== 0) return [];

    const target = totalSkill / (n / 2);
    skill.sort((a, b) => a - b);
    const result = [];

    for (let i = 0; i < n / 2; i++) {
        if (skill[i] + skill[n - 1 - i] !== target) return [];
        result.push([skill[i], skill[n - 1 - i]]);
    }

    return result;
}