function magicTower(nums) {
    let total = 0, minHealth = 0;

    for (let num of nums) {
        total += num;
        if (total < 1) {
            minHealth += 1 - total;
            total = 1;
        }
    }

    return minHealth;
}