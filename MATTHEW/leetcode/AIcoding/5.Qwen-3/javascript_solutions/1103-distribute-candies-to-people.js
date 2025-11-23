function distributeCandies(candies, num_people) {
    let i = 0;
    let give = 1;
    while (candies > 0) {
        if (candies >= give) {
            candies -= give;
            i++;
            give++;
        } else {
            break;
        }
    }
    const result = new Array(num_people).fill(0);
    for (let j = 0; j < i; j++) {
        result[j % num_people] += j + 1;
    }
    if (candies > 0) {
        result[i % num_people] += candies;
    }
    return result;
}