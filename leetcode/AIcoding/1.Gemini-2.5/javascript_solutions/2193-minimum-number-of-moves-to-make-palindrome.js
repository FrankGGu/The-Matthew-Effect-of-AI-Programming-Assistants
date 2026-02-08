var minMovesToMakePalindrome = function(s) {
    let arr = s.split('');
    let n = arr.length;
    let moves = 0;
    let left = 0;
    let right = n - 1;

    while (left < right) {
        if (arr[left] === arr[right]) {
            left++;
            right--;
        } else {
            // Find the matching character for arr[left] from the right side
            // We prioritize the rightmost match to minimize moves
            let k = right;
            while (k > left && arr[k] !== arr[left]) {
                k--;
            }

            if (k === left) { 
                // If k is equal to left, it means arr[left] has no pair
                // to its right within the current [left, right] segment.
                // This character must be the unique middle character of an odd-length palindrome.
                // It needs to be moved to the true middle of the original string.
                // The number of swaps is the distance from its current position 'left'
                // to the middle position 'Math.floor(n / 2)'.
                moves += Math.floor(n / 2) - left;
                left++; // This character is now conceptually handled and moved to the middle
            } else { 
                // Found a match arr[k] for arr[left]
                // Move arr[k] to arr[right] by a series of adjacent swaps.
                // The number of swaps is (right - k).
                moves += (right - k);

                // Shift characters from index k to right-1 one position to the left
                // to make space for arr[k] at arr[right].
                let charToMove = arr[k];
                for (let i = k; i < right; i++) {
                    arr[i] = arr[i+1];
                }
                arr[right] = charToMove;

                left++;
                right--;
            }
        }
    }

    return moves;
};