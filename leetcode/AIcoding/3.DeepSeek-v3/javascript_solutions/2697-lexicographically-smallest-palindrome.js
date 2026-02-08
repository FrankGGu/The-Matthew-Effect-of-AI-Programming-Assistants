var makeSmallestPalindrome = function(s) {
    const arr = s.split('');
    let left = 0;
    let right = arr.length - 1;

    while (left < right) {
        if (arr[left] !== arr[right]) {
            const minChar = arr[left] < arr[right] ? arr[left] : arr[right];
            arr[left] = minChar;
            arr[right] = minChar;
        }
        left++;
        right--;
    }

    return arr.join('');
};