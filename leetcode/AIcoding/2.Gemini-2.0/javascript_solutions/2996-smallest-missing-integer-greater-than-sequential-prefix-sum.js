var smallestMissing = function(nums) {
    let seen = new Set();
    for (let num of nums) {
        seen.add(num);
    }

    let sum = 0;
    let missing = 1;

    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        if (nums[i] !== missing) {
            break;
        }

        if (seen.has(missing)) {
            while (seen.has(missing)) {
                missing++;
            }
        } else {
             break;
        }
    }

    return missing;
};