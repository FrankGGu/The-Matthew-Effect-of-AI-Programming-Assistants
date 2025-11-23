var minimumDifference = function(nums) {
    const n = nums.length;
    const half = n / 2;
    const sum = nums.reduce((a, b) => a + b, 0);
    let ans = Infinity;

    const generateSubsets = (arr) => {
        const subsets = new Map();
        for (let i = 0; i < (1 << arr.length); i++) {
            let count = 0;
            let sum = 0;
            for (let j = 0; j < arr.length; j++) {
                if ((i >> j) & 1) {
                    count++;
                    sum += arr[j];
                }
            }
            if (!subsets.has(count)) {
                subsets.set(count, []);
            }
            subsets.get(count).push(sum);
        }
        for (let arr of subsets.values()) {
            arr.sort((a, b) => a - b);
        }
        return subsets;
    };

    const leftSubsets = generateSubsets(nums.slice(0, half));
    const rightSubsets = generateSubsets(nums.slice(half));

    for (let i = 0; i <= half; i++) {
        const leftArr = leftSubsets.get(i) || [];
        const rightArr = rightSubsets.get(half - i) || [];

        for (let leftSum of leftArr) {
            let target = (sum - 2 * leftSum) / 2;
            let low = 0;
            let high = rightArr.length - 1;
            while (low <= high) {
                const mid = Math.floor((low + high) / 2);
                const rightSum = rightArr[mid];
                ans = Math.min(ans, Math.abs(sum - 2 * (leftSum + rightSum)));
                if (rightSum < target) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
        }
    }

    return ans;
};