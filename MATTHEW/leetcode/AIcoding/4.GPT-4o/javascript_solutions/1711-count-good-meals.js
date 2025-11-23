var countGoodMeals = function(deliciousness) {
    const mod = 10 ** 9 + 7;
    const countMap = new Map();
    let goodMeals = 0;

    for (const dish of deliciousness) {
        for (let power = 1; power <= 2 * (1 << 21); power *= 2) {
            if (countMap.has(power - dish)) {
                goodMeals = (goodMeals + countMap.get(power - dish)) % mod;
            }
        }
        countMap.set(dish, (countMap.get(dish) || 0) + 1);
    }

    return goodMeals;
};