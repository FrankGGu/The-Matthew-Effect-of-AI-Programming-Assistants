var distributeCandies = function(candies, num_people) {
    let result = new Array(num_people).fill(0);
    let i = 0;
    let current = 1;
    while (candies > 0) {
        if (candies >= current) {
            result[i % num_people] += current;
            candies -= current;
        } else {
            result[i % num_people] += candies;
            candies = 0;
        }
        current++;
        i++;
    }
    return result;
};