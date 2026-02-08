var distributeCandies = function(candies, num_people) {
    let result = new Array(num_people).fill(0);
    let currentCandiesToGive = 1;
    let personIndex = 0;

    while (candies > 0) {
        let actualCandiesToGive = Math.min(candies, currentCandiesToGive);
        result[personIndex] += actualCandiesToGive;
        candies -= actualCandiesToGive;
        currentCandiesToGive++;
        personIndex = (personIndex + 1) % num_people;
    }

    return result;
};