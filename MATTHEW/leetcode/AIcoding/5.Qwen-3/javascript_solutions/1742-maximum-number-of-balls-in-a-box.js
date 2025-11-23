function maxBallsInBox(baskets) {
    const count = {};
    let max = 0;

    for (const basket of baskets) {
        const key = basket.toString();
        count[key] = (count[key] || 0) + 1;
        if (count[key] > max) {
            max = count[key];
        }
    }

    return max;
}