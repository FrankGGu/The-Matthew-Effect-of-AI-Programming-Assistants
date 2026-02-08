var majorityElement = function(nums) {
    if (nums.length === 0) {
        return [];
    }

    let candidate1 = 0, count1 = 0;
    let candidate2 = 0, count2 = 0;

    for (let num of nums) {
        if (num === candidate1) {
            count1++;
        } else if (num === candidate2) {
            count2++;
        } else if (count1 === 0) {
            candidate1 = num;
            count1 = 1;
        } else if (count2 === 0) {
            candidate2 = num;
            count2 = 1;
        } else {
            count1--;
            count2--;
        }
    }

    let result = [];
    count1 = 0;
    count2 = 0;

    for (let num of nums) {
        if (num === candidate1) {
            count1++;
        } else if (num === candidate2) { // Important: use else if to avoid double counting if candidate1 == candidate2
            count2++;
        }
    }

    if (count1 > nums.length / 3) {
        result.push(candidate1);
    }
    if (count2 > nums.length / 3) {
        // Only add candidate2 if it's different from candidate1, or if candidate1 wasn't added due to not meeting the threshold
        // The condition `candidate1 !== candidate2` is implicitly handled by `else if` in the second pass.
        // If candidate1 === candidate2, then count2 will only increment if candidate1 wasn't matched in the `if` block.
        // However, if candidate1 === candidate2, only one of them will ever be added to result.
        // The check `candidate1 !== candidate2` is only needed if we used two separate `if` statements.
        // With `else if`, if candidate1 === candidate2, then count2 will remain 0 unless candidate1 isn't matched first.
        // A simpler way to handle this is to ensure we don't add duplicates to the result array.
        // The current logic of checking candidate1 and candidate2 separately and then pushing to result handles this.
        // If candidate1 and candidate2 are the same, only one will be pushed to result.
        if (candidate1 !== candidate2) { // Ensure distinct candidates are added
            result.push(candidate2);
        }
    }

    // In case candidate1 and candidate2 ended up being the same number
    // and that number is indeed a majority element.
    // The previous logic for `result.push(candidate2)` with `if (candidate1 !== candidate2)`
    // would prevent adding the same number twice.
    // If candidate1 === candidate2, and that number is a majority element,
    // it would be added by the `if (count1 > nums.length / 3)` block.
    // The `if (candidate1 !== candidate2)` for candidate2 is correct.
    // Let's re-evaluate the final check for `candidate2` to ensure correctness.
    // If `candidate1 === candidate2`, then `count2` would be 0 (or some other value based on initial pass).
    // The actual count for `candidate1` would be in `count1`.
    // So, if `candidate1 === candidate2`, then `candidate2` should not be checked again.
    // A better way to ensure no duplicates is to use a Set or just be careful with the `if` conditions.

    // Let's simplify the final result check to avoid potential duplicate issues if candidate1 == candidate2
    // and ensure both are checked correctly.

    result = [];
    let realCount1 = 0;
    let realCount2 = 0;

    for (let num of nums) {
        if (num === candidate1) {
            realCount1++;
        }
        if (num === candidate2) {
            realCount2++;
        }
    }

    if (realCount1 > nums.length / 3) {
        result.push(candidate1);
    }
    // Only add candidate2 if it's different from candidate1 AND meets the threshold
    if (candidate1 !== candidate2 && realCount2 > nums.length / 3) {
        result.push(candidate2);
    }

    return result;
};