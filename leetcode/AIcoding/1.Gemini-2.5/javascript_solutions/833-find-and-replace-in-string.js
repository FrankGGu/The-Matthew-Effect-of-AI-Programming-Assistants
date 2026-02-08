var findReplaceString = function(s, indices, sources, targets) {
    let result = s;

    // Iterate from the last index to the first.
    // This is crucial because replacements can change the length of the string,
    // which would invalidate indices for subsequent replacements if processed from left to right.
    // Since indices are sorted in ascending order, iterating backwards ensures
    // that replacements at higher indices are done first, without affecting lower indices.
    for (let i = indices.length - 1; i >= 0; i--) {
        const index = indices[i];
        const source = sources[i];
        const target = targets[i];

        // Check if the substring of `result` starting at `index` and having the length of `source`
        // is exactly equal to `source`.
        if (result.substring(index, index + source.length) === source) {
            // If it matches, perform the replacement.
            // Concatenate the part of the string before the replacement, the target string,
            // and the part of the string after the replacement.
            result = result.substring(0, index) + target + result.substring(index + source.length);
        }
    }

    return result;
};