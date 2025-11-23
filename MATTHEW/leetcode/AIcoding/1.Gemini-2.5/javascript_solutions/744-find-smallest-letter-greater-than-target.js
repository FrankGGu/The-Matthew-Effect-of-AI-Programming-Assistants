var nextGreatestLetter = function(letters, target) {
    let low = 0;
    let high = letters.length - 1;
    let ans = letters[0]; // Default to the first letter for the wrap-around case

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);

        if (letters[mid] > target) {
            ans = letters[mid];
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};