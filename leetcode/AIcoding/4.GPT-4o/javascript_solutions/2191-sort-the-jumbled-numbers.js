var sortJumbled = function(mapping, nums) {
    const mappedNums = nums.map(num => {
        let mappedNum = '';
        for (const digit of String(num)) {
            mappedNum += mapping[digit];
        }
        return Number(mappedNum);
    });

    return nums
        .map((num, index) => [mappedNums[index], num])
        .sort(([mappedA], [mappedB]) => mappedA - mappedB)
        .map(([, original]) => original);
};