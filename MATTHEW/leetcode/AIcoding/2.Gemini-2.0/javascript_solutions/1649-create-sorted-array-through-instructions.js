var createSortedArray = function(instructions) {
    const MOD = 10**9 + 7;
    let sorted = [];
    let cost = 0;

    function binarySearchLeft(arr, target) {
        let left = 0;
        let right = arr.length;
        while (left < right) {
            let mid = Math.floor((left + right) / 2);
            if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    function binarySearchRight(arr, target) {
        let left = 0;
        let right = arr.length;
        while (left < right) {
            let mid = Math.floor((left + right) / 2);
            if (arr[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    for (let i = 0; i < instructions.length; i++) {
        let num = instructions[i];
        let less = binarySearchLeft(sorted, num);
        let greater = sorted.length - binarySearchRight(sorted, num - 1);
        cost = (cost + Math.min(less, greater)) % MOD;
        sorted.splice(less, 0, num);
    }

    return cost;
};