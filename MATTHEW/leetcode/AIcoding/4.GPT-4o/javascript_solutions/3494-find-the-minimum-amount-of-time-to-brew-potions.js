function minTimeToBrew(potions) {
    potions.sort((a, b) => a - b);
    let totalTime = 0;
    let maxTime = 0;

    for (const potion of potions) {
        totalTime += potion;
        maxTime = Math.max(maxTime, totalTime);
    }

    return maxTime;
}