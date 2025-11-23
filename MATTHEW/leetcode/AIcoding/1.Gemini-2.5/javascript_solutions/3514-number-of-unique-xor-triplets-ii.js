var uniqueXORTriplets = function(nums) {
    const numSet = new Set(nums);
    const uniqueArr = Array.from(numSet);
    uniqueArr.sort((a, b) => a - b);

    let count = 0;
    const n = uniqueArr.length;

    for (let i = 0; i < n; i++) {
        const a = uniqueArr[i];
        for (let j = i + 1; j < n; j++) {
            const b = uniqueArr[j];
            const c = a ^ b;

            // To form a unique triplet {a, b, c} with a < b < c,
            // we need c to be present in the set and c must be greater than b.
            // Since uniqueArr is sorted and we iterate with i < j, we have a < b.
            // The condition c > b implicitly ensures c is distinct from a and b:
            // - If c were equal to a, then a > b would be false (since a < b).
            // - If c were equal to b, then b > b would be false.
            if (numSet.has(c) && c > b) {
                count++;
            }
        }
    }

    return count;
};