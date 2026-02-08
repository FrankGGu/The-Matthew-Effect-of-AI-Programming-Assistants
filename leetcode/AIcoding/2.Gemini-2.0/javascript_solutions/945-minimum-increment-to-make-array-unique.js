var minIncrementForUnique = function(nums) {
    nums.sort((a, b) => a - b);
    let moves = 0;
    let taken = [];

    for (let num of nums) {
        if (taken.length > 0 && num <= taken[taken.length - 1]) {
            let expected = taken[taken.length - 1] + 1;
            moves += expected - num;
            taken.push(expected);
        } else {
            taken.push(num);
        }
    }

    return moves;
};