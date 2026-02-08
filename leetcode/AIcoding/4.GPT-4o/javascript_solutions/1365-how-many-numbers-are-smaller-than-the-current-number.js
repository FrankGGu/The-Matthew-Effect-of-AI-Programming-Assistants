var smallerNumbersThanCurrent = function(nums) {
    const sorted = [...nums].sort((a, b) => a - b);
    const map = new Map();
    sorted.forEach((num, index) => {
        if (!map.has(num)) {
            map.set(num, index);
        }
    });
    return nums.map(num => map.get(num));
};