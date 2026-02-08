var nextGreatestLetter = function(letters, target) {
    let left = 0;
    let right = letters.length - 1;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (letters[mid] > target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return letters[left % letters.length];
};