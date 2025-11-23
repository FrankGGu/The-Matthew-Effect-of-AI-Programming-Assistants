function numberOfSubstringsWithDominantOnes(s) {
    let count = 0;
    let left = 0;
    let ones = 0;
    for (let right = 0; right < s.length; right++) {
        if (s[right] === '1') {
            ones++;
        }
        while (ones > 0 && ones <= right - left + 1 - ones) {
            if (s[left] === '1') {
                ones--;
            }
            left++;
        }
        count += left;
    }
    return count;
}