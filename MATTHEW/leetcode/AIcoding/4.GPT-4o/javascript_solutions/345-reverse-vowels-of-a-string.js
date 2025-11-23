var reverseVowels = function(s) {
    const vowels = 'aeiouAEIOU';
    let left = 0, right = s.length - 1;
    const arr = s.split('');

    while (left < right) {
        if (vowels.indexOf(arr[left]) === -1) {
            left++;
            continue;
        }
        if (vowels.indexOf(arr[right]) === -1) {
            right--;
            continue;
        }
        [arr[left], arr[right]] = [arr[right], arr[left]];
        left++;
        right--;
    }

    return arr.join('');
};