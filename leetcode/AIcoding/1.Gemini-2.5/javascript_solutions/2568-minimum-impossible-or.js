var minImpossibleOR = function(nums) {
    nums.sort((a, b) => a - b);

    let currentMaxOR = 0;

    for (const num of nums) {
        if (num > currentMaxOR + 1) {
            return currentMaxOR + 1;
        }

        currentMaxOR |= num;
    }

    return currentMaxOR + 1;
};