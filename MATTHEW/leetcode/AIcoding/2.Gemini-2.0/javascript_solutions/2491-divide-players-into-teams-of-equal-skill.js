var dividePlayers = function(skill) {
    skill.sort((a, b) => a - b);
    let sum = 0;
    let left = 0;
    let right = skill.length - 1;
    let targetSum = skill[0] + skill[skill.length - 1];

    while (left < right) {
        if (skill[left] + skill[right] !== targetSum) {
            return -1;
        }
        sum += skill[left] * skill[right];
        left++;
        right--;
    }

    return sum;
};