function countHouses(distance, houses) {
    let count = 0;
    for (let house of houses) {
        if (house === distance) {
            count++;
        }
    }
    return count;
}