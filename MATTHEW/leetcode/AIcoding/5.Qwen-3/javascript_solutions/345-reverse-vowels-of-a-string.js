function reverseVowels(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);
    const sArray = s.split('');
    let left = 0;
    let right = s.length - 1;

    while (left < right) {
        while (left < right && !vowels.has(sArray[left])) {
            left++;
        }
        while (left < right && !vowels.has(sArray[right])) {
            right--;
        }
        if (left < right) {
            [sArray[left], sArray[right]] = [sArray[right], sArray[left]];
            left++;
            right--;
        }
    }

    return sArray.join('');
}