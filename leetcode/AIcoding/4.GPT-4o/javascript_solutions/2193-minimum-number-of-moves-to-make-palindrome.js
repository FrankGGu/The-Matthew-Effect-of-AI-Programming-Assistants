var minMovesToMakePalindrome = function(s) {
    const n = s.length;
    const countChars = new Array(26).fill(0);
    for (const char of s) {
        countChars[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let oddCount = 0;
    for (const count of countChars) {
        if (count % 2 !== 0) {
            oddCount++;
        }
    }

    if (oddCount > 1) return -1;

    let moves = 0;
    const arr = Array.from(s);
    let left = 0, right = n - 1;

    while (left < right) {
        if (arr[left] === arr[right]) {
            left++;
            right--;
        } else {
            let l = left, r = right;
            while (r > l && arr[l] !== arr[r]) r--;
            if (r === l) {
                // Character not found, need to swap with next
                [arr[l], arr[l + 1]] = [arr[l + 1], arr[l]];
                moves++;
            } else {
                // Found the matching character
                for (let i = r; i < right; i++) {
                    [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
                    moves++;
                }
                left++;
                right--;
            }
        }
    }

    return moves;
};