var magicTower = function(nums) {
    let totalSum = 0;
    for (const num of nums) {
        totalSum += num;
    }

    if (totalSum < 0) {
        return -1;
    }

    let currentHealth = 0;
    let minHealth = 0;

    for (const num of nums) {
        currentHealth += num;
        minHealth = Math.min(minHealth, currentHealth);
    }

    return 1 - minHealth;
};