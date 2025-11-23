var dividePlayers = function(skill) {
    skill.sort((a, b) => a - b);

    const n = skill.length;
    if (n === 0) {
        return 0;
    }

    const targetSum = skill[0] + skill[n - 1];
    let totalChemistry = 0;

    let left = 0;
    let right = n - 1;

    while (left < right) {
        if (skill[left] + skill[right] !== targetSum) {
            return -1;
        }
        totalChemistry += skill[left] * skill[right];
        left++;
        right--;
    }

    return totalChemistry;
};