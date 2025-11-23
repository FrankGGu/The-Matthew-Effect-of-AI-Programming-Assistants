var distributeCandies = function(candies, num_people) {
    const result = new Array(num_people).fill(0);
    let i = 0;
    let give = 1;

    while (candies > 0) {
        result[i % num_people] += Math.min(candies, give);
        candies -= give;
        give++;
        i++;
    }

    return result;
};