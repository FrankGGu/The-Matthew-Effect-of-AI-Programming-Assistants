var reverseOnlyLetters = function(s) {
    let arr = s.split('');
    let left = 0;
    let right = arr.length - 1;
    while (left < right) {
        while (left < right && !isLetter(arr[left])) {
            left++;
        }
        while (left < right && !isLetter(arr[right])) {
            right--;
        }
        if (left < right) {
            [arr[left], arr[right]] = [arr[right], arr[left]];
            left++;
            right--;
        }
    }
    return arr.join('');
};

function isLetter(c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}