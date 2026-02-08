var countDistinctIntegers = function(nums) {
    const distinctNumbers = new Set();

    for (const num of nums) {
        distinctNumbers.add(num);

        let reversedNum = 0;
        let temp = num;
        while (temp > 0) {
            reversedNum = reversedNum * 10 + (temp % 10);
            temp = Math.floor(temp / 10);
        }
        distinctNumbers.add(reversedNum);
    }

    return distinctNumbers.size;
};