var minCostToMakeArrayEqualindromic = function(nums) {
    const isPalindromic = (num) => {
        const s = num.toString();
        let left = 0, right = s.length - 1;
        while (left < right) {
            if (s[left] !== s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    };

    const findClosestPalindromic = (num) => {
        if (isPalindromic(num)) return num;

        let lower = num - 1;
        while (lower >= 0 && !isPalindromic(lower)) {
            lower--;
        }

        let higher = num + 1;
        while (!isPalindromic(higher)) {
            higher++;
        }

        if (lower < 0) return higher;
        return (num - lower) <= (higher - num) ? lower : higher;
    };

    const palindromicNumbers = nums.map(num => findClosestPalindromic(num));
    palindromicNumbers.sort((a, b) => a - b);
    const median = palindromicNumbers[Math.floor(palindromicNumbers.length / 2)];

    let totalCost = 0;
    for (const num of nums) {
        const pal = findClosestPalindromic(num);
        totalCost += Math.abs(pal - median);
    }

    return totalCost;
};