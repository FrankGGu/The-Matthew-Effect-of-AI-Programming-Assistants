function numberOfSubstrings(s, k = 3) {
    const count = new Array(26).fill(0);
    let left = 0, result = 0;
    let unique = 0;

    for (let right = 0; right < s.length; right++) {
        const index = s[right].charCodeAt(0) - 'a'.charCodeAt(0);
        if (count[index] === 0) unique++;
        count[index]++;

        while (unique === k) {
            result += s.length - right;
            const leftIndex = s[left].charCodeAt(0) - 'a'.charCodeAt(0);
            count[leftIndex]--;
            if (count[leftIndex] === 0) unique--;
            left++;
        }
    }

    return result;
}