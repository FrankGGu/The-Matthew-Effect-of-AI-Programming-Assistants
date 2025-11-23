function minCostToMakeArrayEqualindromic(nums) {
    function isPalindrome(x) {
        const s = x.toString();
        return s === s.split('').reverse().join('');
    }

    function getMinCost(target) {
        return nums.reduce((total, num) => total + Math.abs(num - target), 0);
    }

    let minCost = Infinity;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        const num = nums[i];
        for (let j = 0; j < 10000; j++) {
            const candidate = num + j;
            if (isPalindrome(candidate)) {
                minCost = Math.min(minCost, getMinCost(candidate));
                break;
            }
        }
        for (let j = 0; j < 10000; j++) {
            const candidate = num - j;
            if (candidate > 0 && isPalindrome(candidate)) {
                minCost = Math.min(minCost, getMinCost(candidate));
                break;
            }
        }
    }

    return minCost;
}