var countExcellentPairs = function(nums) {
    const uniqueNums = [...new Set(nums)];
    const bitCounts = uniqueNums.map(num => num.toString(2).split('').filter(bit => bit === '1').length);
    const countMap = {};
    for (const count of bitCounts) {
        countMap[count] = (countMap[count] || 0) + 1;
    }

    let result = 0;
    for (const count1 of bitCounts) {
        for (const count2 in countMap) {
            if (count1 + parseInt(count2) >= 2) {
                result += countMap[count2];
            }
        }
    }

    return result;
};