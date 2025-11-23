var minMovesToMakePalindrome = function(s) {
    let n = s.length;
    let count = 0;
    let left = 0, right = n - 1;
    let arr = s.split('');

    while (left < right) {
        if (arr[left] === arr[right]) {
            left++;
            right--;
        } else {
            let i = right;
            while (i > left && arr[i] !== arr[left]) i--;
            if (i === left) {
                // No matching character found, swap with next one
                [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
                count++;
            } else {
                // Move the matching character to the right end
                while (i < right) {
                    [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
                    count++;
                    i++;
                }
                left++;
                right--;
            }
        }
    }
    return count;
};