function cookDishes(dishes) {
    let totalTime = 0;
    for (let i = 0; i < dishes.length; i++) {
        totalTime += dishes[i];
    }
    return totalTime;
}