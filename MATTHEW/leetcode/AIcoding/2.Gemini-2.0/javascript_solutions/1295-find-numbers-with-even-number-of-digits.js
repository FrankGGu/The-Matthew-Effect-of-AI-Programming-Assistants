var findNumbers = function(nums) {
    let count = 0;
    for (let num of nums) {
        let digits = 0;
        let temp = num;
        while (temp > 0) {
            temp = Math.floor(temp / 10);
            digits++;
        }
        if (digits % 2 === 0) {
            count++;
        }
    }
    return count;
};